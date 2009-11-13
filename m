From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Fri, 13 Nov 2009 12:43:31 -0800
Message-ID: <4AFDC4F3.1050607@gmail.com>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org> <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com> <20091111220832.GA31620@progeny.tock> <4AFCFF50.5080401@gmail.com> <20091113070652.GA3907@progeny.tock> <4AFD06CD.7090003@gmail.com> <20091113085028.GA4804@progeny.tock> <20091113090343.GA5355@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 21:43:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N92zg-0004rN-Jz
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 21:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547AbZKMUne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 15:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757495AbZKMUnd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 15:43:33 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47241 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757392AbZKMUnc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 15:43:32 -0500
Received: by bwz27 with SMTP id 27so3875804bwz.21
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 12:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=othGMPX5+c9TchLcPZK7TIQ7L1zxI6zbRi8JCe52NBY=;
        b=p9S16cZPG0nQDtH5klpED3SVxZoNN9E/BPgA1UNHLSD8oOwPfMEIu4O2MORWfdVDG6
         DNi9sMhMYLHFXxdjkLGrGdShT7e/+iP847ukyyihurylFir4kkIFkasr7ul7DhHPauW3
         S4PusgDzZBXrj+XxHzBX/0PLJRqURyEHD78nI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=GYvhM6FE0yhcU2xgANq3PT7nznb8ehRfD2J8iy39Mi0ZDFQISVLPzM0CoSTP4Itlbe
         le3EV84d4tVlodN/EhVuo6wqJCVoRrE2Zt37aIiLB4mcdaufhKBmXXY9HQrXkw03ftxj
         qHawhkqtALpURN2LhBhN9ISUTwfSUnm7Hudw0=
Received: by 10.103.50.21 with SMTP id c21mr2210562muk.27.1258145017200;
        Fri, 13 Nov 2009 12:43:37 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id u26sm645718mug.3.2009.11.13.12.43.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 12:43:36 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <20091113090343.GA5355@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132843>

Jonathan Nieder wrote:
> On my slow laptop (P3 600MHz), system-wide bash completions take
> too much time to load (> 2s), and a significant fraction of this
> time is spent loading git-completion.bash:
>   
[...]
> Suggested-by: Kirill Smelkov <kirr@mns.spb.ru>
> Cc: Shawn O. Pearce <spearce@spearce.org>
> Cc: Stephen Boyd <bebarino@gmail.com>
> Cc: Sverre Rabbelier <srabbelier@gmail.com>
> Cc: Junio C Hamano <junio@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

I was under the impression that setting variables during completion 
meant they were lost at the end of the completion cycle. So to be safe I 
put a 'sleep 5' in __git_list_porcelain_commands() and it only stalled 
me once :-)

I see a small problem, but it can be fixed in another patch. git merge 
-s <TAB><TAB> the first time when you're not in a git directory will 
make git merge -s <TAB><TAB> after never complete correctly even in a 
git directory. I guess this become more serious if git isn't in your 
path initially and you do git <TAB><TAB> and then git becomes part of 
your path and you try again. Here you lose porcelain completion. This is 
probably never going to happen though, right?

Plus it seems that __git_all_commands is computed twice if I git 
<TAB><TAB> and then git help <TAB><TAB> after. Can that be avoided?

Squashing this on top fixes the two typos you mentioned.

---->8----

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7088ec7..6817953 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1082,7 +1082,7 @@ _git_help ()
                ;;
        esac
        __git_compute_all_commands
-       __gitcomp "__git_all_commands
+       __gitcomp "$__git_all_commands
                attributes cli core-tutorial cvs-migration
                diffcore gitk glossary hooks ignore modules
                repository-layout tutorial tutorial-2
@@ -1541,7 +1541,7 @@ _git_config ()
                local pfx="${cur%.*}."
                cur="${cur#*.}"
                __git_compute_all_commands
-               __gitcomp "__git_all_commands" "$pfx" "$cur"
+               __gitcomp "$__git_all_commands" "$pfx" "$cur"
                return
                ;;
        remote.*.*)
