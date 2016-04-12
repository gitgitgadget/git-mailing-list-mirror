From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] upload-pack: Exit when server finishes sending
 shallow-update in stateless RPC mode
Date: Tue, 12 Apr 2016 07:39:14 +0200
Message-ID: <570C8A02.4050703@web.de>
References: <1460436940-16165-1-git-send-email-stanhu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stan Hu <stanhu@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 12 07:39:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apr30-0007Rj-EO
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 07:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbcDLFja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 01:39:30 -0400
Received: from mout.web.de ([212.227.15.3]:56961 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbcDLFj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 01:39:29 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lw0vl-1bqo2a1Cij-017pJ7; Tue, 12 Apr 2016 07:39:17
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.6.0
In-Reply-To: <1460436940-16165-1-git-send-email-stanhu@gmail.com>
X-Provags-ID: V03:K0:BQ+8qqX1RbRRAjoMn5BlFWRX+Ft2ZZA3Tt3CK+QGPT79AF5my3u
 B/tZh8O6u0FiXLzFmQd/GuYa5yqYs0KaxI9x7qsBsUWDl+RPTOsQF1SqGiQmHJcEXTG0NZc
 p1Rj/jXnoEt1PUsWhlTclbEUwJ2xxmD00hU6vZfkAOTHHge1aCt0ii9R/q7Wlrn3cR6fwA3
 EjG181KYj72gWdksbT1sA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:flvejYrAN7w=:6CFOJ7zs8tr9uHInlMsJ4W
 81QsPvhFyqwsWrMLKaf5w+sbCGr7VIKsUJ92nl+1HysiyxXjbUqLciMV4gVhSJLrePF4zGEHy
 gLcnsTRe2FM893Hua8bRCmvCrgYCzWRb//IcjsQGrJDU4loM26W5vzuKzdh309+8VkL4/xspA
 6sZpA4flojIWSkPi3BXBZH2hMJrWpXeE1nhKNZCUFui4BV0rm4duiQjYixD9rwigF+P3842Bh
 x88Zty7dGPOyfCEGIOSFdzZqvOYdsBY2tj3s6fVmLkj7rrMSZyu2VL0PwfKvanrSaeGN9geIH
 YUSnv9waEKCCmBCDz+m95QfZbAtbi7SKT5VAbDiCw0W+Pd1ZuU1FEchiZY99EYs+tnd9utwnu
 Glb7XetP9CYb2CxvcqbAn4c73t1YvjI/008aedTg5xvF8a8ARMHZQ9xpsuAyE+APtHbIHtO2q
 ks8lFZLfPnbUjzQuee3XZmJb4gaosb/fozZF8L9dN2AVsUBOsKTp66S0SMm4+DWuGFxekOaBi
 yE8xAyTuBK1KJmyPRJfJ44riyd2x5MnEkV452AVBNuxaJTc+VpZd3Cg7K6hYdOA7VQWC1k6+h
 M9QT7pf1TgQXCiiADFozmP8UYWg4zDQUd2QyFoQbXY4F+K6dKKvh9Z7zwWMhEoLSwi9ba+5zW
 x6crONwSqX9KRNRGNMP+dFvnPrB0XSXYqd5YdWn2U0gAbd+z5gvsxYZGbyBA6EiNVyh1Fvb1f
 MQWPWUEQX0yHeRFc4Lqv6s/ryxjpgTa4gAeK/jxZ3jecdCwNUdGcEKZqTdUCXHKuXjJPMZU9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291245>

On 04/12/2016 06:55 AM, Stan Hu wrote:
> In the stateless RPC case, the server should respond to the client's depth
> request with the set of commits which are no deeper than the desired
> depth. Once this finishes, the server should terminate and receive the reply
> in another POST request.
>
> Previously the server would sit idle and die when it detected the client
> closed the connection.
Some loose thoughts about the wording(s):
the server did not terminate (it's a machine, a hardware), a process 
terminated.
And it did not "die" either, it terminates gracefully.
How about something like this:

In the stateless RPC case, the server responds to the client's depth
request. Once this finishes, the server should terminate.
The reply is and received in another POST request.

Previously the server would sit idle and terminates when it detected the client
closed the connection.

---------------

But, but,
there is may be more.
What happens, when the server process calls exit(0) ?
Is there a guarantee that the data is send out on the socket?
Or is the exit(0) ripping out all the data in the TCP send buffers,
and the client may, or not may, receive the complete packets.

Beside that, a close() of a socket means that the socket is going into
time_wait() state.
Is this desirable for a server to have many sockets in time_wait ?
(This is out of my head, I may be wrong)

Could it be that the client is broken ?
Could you elaborate this a little bit more ?


> Signed-off-by: Stan Hu <stanhu@gmail.com>
> ---
>   upload-pack.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index b3f6653..4fb1e60 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -676,6 +676,8 @@ static void receive_needs(void)
>   			register_shallow(object->oid.hash);
>   		}
>   		packet_flush(1);
> +		if (stateless_rpc)
> +			exit(0);
>   	} else
>   		if (shallows.nr > 0) {
>   			int i;
