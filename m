From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-am --one
Date: Tue, 13 Dec 2005 17:54:01 -0800
Message-ID: <7v7ja85tqe.fsf@assigned-by-dhcp.cox.net>
References: <439F7105.9050302@zytor.com>
	<7vy82o5uss.fsf@assigned-by-dhcp.cox.net> <439F79B3.6000309@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 02:55:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmLqI-0005UM-KM
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 02:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVLNByD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 20:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbVLNByD
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 20:54:03 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:10954 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030204AbVLNByD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 20:54:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051214015317.JYWE20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 20:53:17 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <439F79B3.6000309@zytor.com> (H. Peter Anvin's message of "Tue,
	13 Dec 2005 17:47:31 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13614>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>> I understand the motivation, but I suspect skipping mailsplit
>> might be simpler, like this untested code perhaps?
>> 	case "$one" in
>>         '')
>>         	... original code ...
>> 		;;
>>         *)
>> 		one=`printf "%${prec}d" 1`
>>         	cat "$@" >"$dotest/$one"
>>                 echo "$one" >"$dotest/last"
>>                 ;;
>> 	esac
>>
>
> If that works, great.  I just implemented it in the "most obviously 
> correct" way, meaning with as few changes as possible.

Another thing you may probably want is to loop over "$@", so
that the flag is not --one anymore, but --2822 (or --bare as
opposed to mbox format) and do something like this:

	case "$series_of_2822_messages" in
        '') ... original code ... ;;
        *)
        	i=1
                for input
                do
			this=`printf "%${prec}d" $i
                        cp "$input" "$dotest/$this"
                        i=$(($i+1))
		done
                printf "%${prec}d" $# >"$dotest/last"
                ;;
	esac
