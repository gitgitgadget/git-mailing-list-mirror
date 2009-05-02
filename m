From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: specialize diff options for emerge and
	ecmerge
Date: Sat, 2 May 2009 12:46:37 -0700
Message-ID: <20090502194636.GA599@gmail.com>
References: <1241254641-54338-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: charles@hashpling.org, git@vger.kernel.org
To: gitster@pobox.com, markus.heidelberg@web.de,
	marcin.zalewski@gmail.com
X-From: git-owner@vger.kernel.org Sat May 02 21:46:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0LAk-0002Nr-NN
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 21:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343AbZEBTqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 15:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756016AbZEBTqq
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 15:46:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:29972 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989AbZEBTqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 15:46:45 -0400
Received: by rv-out-0506.google.com with SMTP id f6so675845rvb.5
        for <git@vger.kernel.org>; Sat, 02 May 2009 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6jBs0THw09DieuTy3RLSLsxb9hq/rKry/Dfx5lIs5lE=;
        b=DpSYcyAxdpmY0f+4mj0UT+8xhNESLS+T+FfDcbl4y3cuknI70TWhzyKa2kM7smZdR3
         5q3LKRzvp0Whw2n2ro4B7vcKCFwux6aOLmtLFCWDaFbps6Dy9y4nR/77ZFYBc2sXrdSR
         V14JWbl6k93nhSiVegr+BbG2qJ1UvP3lbGhHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z4jKHDXJtXGV+S30Ay9gY2hbtkhGjHs0Yz0YXLmsgxMyHPFzYtlzVY6BOIQeV0PSVE
         cEZRYjyhXLADHCQw5vRNX9eRve/ZwKj6sFqcyMDCaIZuPfQKri3vIuk3kJ4qwfbGlV7d
         q3jkbAkH1vW9HjBNtAsMVXLmLHP1qyz/CKLgY=
Received: by 10.115.110.15 with SMTP id n15mr3040229wam.144.1241293604808;
        Sat, 02 May 2009 12:46:44 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n30sm6928642wag.28.2009.05.02.12.46.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 May 2009 12:46:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1241254641-54338-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118142>

On  0, David Aguilar <davvid@gmail.com> wrote:
> 
> Regarding ecmerge:  I found the --mode=diff2
> flag by reading their documenation:
> 
> http://www.elliecomputing.com/OnlineDoc/ecmerge_EN/52335623.asp
> 
> I don't have ecmerge installed at all, so I'm just
> going by the book on this one.  It *looks* correct,
> and probably is, but let it be known that I
> haven't tested the ecmerge snippet myself.


I installed ecmerge on a mac today and gave this a try.
ecmerge is indeed better with this patch.

After configuring the path it all "just works":

$ git config --global mergetool.ecmerge.path \
	/Applications/ECMerge.app/Contents/MacOS/guimerge

We now get a simple side-by-side diff without the
merge pane at the bottom of the screen.  Nice.


If an emacs user could comment on the emerge snippet
below (or perhaps suggest a better one ;)) then that
would make me happy.  As is, I have tested the
emacs emerge snippet and it works, but I'm not
sure if that's enough to resolve the issue reported
by Marcin.  Marcin?

Here's the original thread:
http://article.gmane.org/gmane.comp.version-control.git/117930


> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index a16a279..8b5e6a8 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -248,7 +248,7 @@ run_merge_tool () {
>  			status=$?
>  		else
>  			"$merge_tool_path" -f emerge-files-command \
> -				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
> +				"$LOCAL" "$REMOTE"
>  		fi
>  		;;

-- 
		David
