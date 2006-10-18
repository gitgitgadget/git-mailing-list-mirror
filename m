From: Markus Amsler <markus.amsler@oribi.org>
Subject: Re: [PATCH] git-imap-send: Strip smtp From_ header from imap message.
Date: Wed, 18 Oct 2006 10:53:45 +0200
Message-ID: <4535EB99.3090006@oribi.org>
References: <452EBF77.7040301@oribi.org> <7vlknegnwk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mike McCormack <mike@codeweavers.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 10:59:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7H2-0002WG-Ei
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 10:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWJRI7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 04:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWJRI7h
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 04:59:37 -0400
Received: from fix-cable-customer.128.177.162.195.yetnet.ch ([195.162.177.128]:53121
	"EHLO khufu") by vger.kernel.org with ESMTP id S1750866AbWJRI7g
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 04:59:36 -0400
Received: from [192.168.67.232] (helo=[192.168.67.232])
	by khufu with esmtp (Exim 4.50)
	id 1Ga7ED-0004PQ-Jz; Wed, 18 Oct 2006 10:56:45 +0200
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlknegnwk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29206>

Junio C Hamano wrote:
> Markus Amsler <markus.amsler@oribi.org> writes:
> 
>> Cyrus imap refuses messages with a 'From ' Header.
>>
>> Signed-off-by: Markus Amsler <markus.amsler@oribi.org>
> 
> Do you know if this change does not upset other implementations
> of imap servers?
I only tested it with cyrus 2.1.18 on debian. I did some research: The 
From_ header field was introduced in rfc976 which only affects UUCP(Unix 
to Unix CoPy). I assume it's an invalid header field in SMTP/IMAP, and 
most implementation ignores it.
I'm no mail header guru, so I could be wrong

Markus
> 
> Mike, are you Ok with this change?
> 
> ---
>   imap-send.c |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/imap-send.c b/imap-send.c
> index 362e474..16804ab 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1226,6 +1226,14 @@ split_msg( msg_data_t *all_msgs, msg_dat
>  	if (msg->len < 5 || strncmp( data, "From ", 5 ))
>  		return 0;
> 
> +	p = strchr( data, '\n' );
> +	if (p) {
> +		p = &p[1];
> +		msg->len -= p-data;
> +		*ofs += p-data;
> +		data = p;
> +	}
> +
>  	p = strstr( data, "\nFrom " );
>  	if (p)
>  		msg->len = &p[1] - data;
> 
> 
