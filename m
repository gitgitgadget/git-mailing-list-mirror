From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Sat, 7 Nov 2015 07:28:30 +0100
Message-ID: <563D9A0E.8050405@web.de>
References: <1446853737-19047-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	j6t@kdbg.org
X-From: git-owner@vger.kernel.org Sat Nov 07 07:29:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zuwzy-0007L6-Lu
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 07:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbbKGG3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 01:29:09 -0500
Received: from mout.web.de ([212.227.17.12]:50721 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbbKGG3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2015 01:29:08 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MMn1H-1ZnVGb3vkl-008ZTQ; Sat, 07 Nov 2015 07:28:39
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <1446853737-19047-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:1qViZEocOpvHaqABo/y/hBl6xs9S1/bopjm7lo3pVr+pVuQb+MP
 ewpT5Zj7N1zIdHpJoqyq1M5Y8X0Puuc7j/+BC9jg/DyhmF7G7e/+RRBlkdjwcn9fL6o45DN
 bn9ApFZfS/8WGC7HGCfy0kMgZXa5FDRT/HRfghslXnW9qFNOnF+zw9H0excy3xyEQENvCKN
 8SYAGZcjBIg3yEdIQYEgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NtchMszuj4s=:+3DAw2FlNquHyu+A3IcTAR
 7tCb9fZ9HKO1bnvpHWLbE0rI27bkJprMfXLq7jN6+ux81OZGDAyxG/79uWPnI2GbAhNJCeFc2
 W5jA4feRAT+oHwht8/cI29Ysx24l+yxqTzLJAe0plC9g5Onn9ngESm8E9PNhMRmwMvwC0QauU
 pIzVx1ikdKXAOzDXY/8ANE3Z1IXbPknxujylOf2agq2sOMNuhYdaFSBhg7zd6iw+0YE3F1/B2
 HnsDoNZjoNgrh5DjFGPgO65YK5lBzlY2cEsN3/B/LU9LJ+q2u6O98Jd8S/Kw8YQN+sPZZaNes
 Fdu/paE93kUH9JzfNqnC8SqPsmMs2hzuYAVJD22xVEGuSSIH1mA8fmt9NvGZARoHO+wUWpN68
 Cc9ikn+94zbWkLkQIskuP0nKm5CKRkhxb7/TSiOJnUz6sxzI57LzsOVs/JbX53iEyjN7xzGzH
 TtW+88vPgMKz0B95yVqRLMlryrHhmJhgdZLjU2ykDV7dmdl5pWBBiBxSbSP7ZDB+Yg/sTuy8G
 04XLt8ZZmLlCu/I7wmLD0klxPd3FLvExWxd+hxcU9RcJnQlIFsusrzkFoZdqgyRw04BTeFl8a
 pZUlnlPMv3NaZZm6uXuosOIWCisQ57MGbdTwRzmkuhQIcBrtPCDVvDmKxTX5H7/fqNH7+STbb
 0pvCBYW9kkqfswFc5auXG5mP82MkB4vfM1GwwGZdUGx5fTuPrjGA+MYmM/+0lntcv0MS6F2/D
 mvmPPHlQXJwWpXX2iiY0KNv8JmsN2zV05f4o+SUEO2cFAfZHd13q7AqOEU7oL1iMe8+OEpnQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281014>

On 07.11.15 00:48, Stefan Beller wrote:
>  
> +enum child_state {
> +	FREE,
> +	WORKING,
> +	WAIT_CLEANUP,
> +};

This kind of  "generic names" feels are begging for 
name clash, some day, may be in the future.
How about something like this:
> +	GIT_CP_FREE,
> +	GIT_CP_WORKING,
> +	GIT_CP_WAIT_CLEANUP,
