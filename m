From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: Re: [PATCH] mergetool: Use merge.tool config option.
Date: Sun, 18 Mar 2007 21:11:07 -0400
Message-ID: <3f80363f0703181811x54acb3f4n689f4fd68f5a5dbe@mail.gmail.com>
References: <11742343911678-git-send-email-jbowes@dangerouslyinc.com>
	 <7vwt1em6gf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tytso@mit.edu
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 02:11:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT6P1-0006w1-C9
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 02:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbXCSBLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 21:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbXCSBLJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 21:11:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:5349 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964930AbXCSBLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 21:11:08 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1232927wry
        for <git@vger.kernel.org>; Sun, 18 Mar 2007 18:11:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=hWxM/furLCrM3z1LHzBglYUzetM1eWYcOwuPJHFxv7zkeFjj5hT1mRfb793JeCB6aJ2OOFYfzf8D+YgtXCr28q6gTkMfZnkCVRMQxUca/B6TtoChDuiWNqPLp85q8Qz/r/OqfjmsEna8ouk7bnvzmOTspgZYIkdBwI9O1CLW3Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TX7Nov07UDR8V2VZ74UJC4yoh2Fnz6CvgDagTTMjwn3oCZBVwzvhvAq4nwcJB9R331ClU8JdoYBi4mm9VAcbWQ+VWXYrWF8QoQvI+4wD5R51XCaskQD6Fnw/sT9HItlsk20uq8FJDmqsTcaVc0htHEMfleeMMAbQmNxJ+ef18Wk=
Received: by 10.64.91.15 with SMTP id o15mr6596867qbb.1174266667499;
        Sun, 18 Mar 2007 18:11:07 -0700 (PDT)
Received: by 10.114.194.4 with HTTP; Sun, 18 Mar 2007 18:11:07 -0700 (PDT)
In-Reply-To: <7vwt1em6gf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: 31a44d73503fd399
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42553>

On 3/18/07, Junio C Hamano <junkio@cox.net> wrote:
> The problem description looks correct, but I think the original
> meant to reject configuration value for merge_tool that is not
> supported with the version of the script (and screwed up).

There's a bit later on in mergetool that errors out if you have
provided an unknown merge program (either via the command line or
through your config). The command line and the config ways should
probably behave the same, eh? If so, the case block should be brought
up one level like so:

> IOW, wouldn't this be a better way?
>
>         if test -z "$merge_tool"
>         then
>                 merge_tool=`git-config merge.tool`
           fi
          case "$merge_tool" in
          kdiff3 | tkdiff | xxdiff | meld | emerge)
                     ;; # happy
          *)
                     echo >&2 "We do not know how to drive $merge_tool"
                     echo >&2 "Resetting to default..."
                     unset merge_tool
                     ;;
          esac

And then remove the 'Unknown mergetool' bit.

I think either way is fine since they both let you know that you've
entered gobbledeegook or forgot to install something, so I'll defer to
you all for the choice on which way to go.

-James
