From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] completion: suppress zsh's special 'words' variable
Date: Mon, 9 May 2011 22:17:08 -0500
Message-ID: <20110510031708.GD26619@elie>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
 <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
 <20110510025529.GA26619@elie>
 <20110510025916.GB26619@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 05:17:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJdRo-0006ff-7C
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 05:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab1EJDRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 23:17:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43420 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab1EJDRM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 23:17:12 -0400
Received: by iyb14 with SMTP id 14so4843231iyb.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6HDbGJCc+DItBe/cSTLzlSALK5vO9CoINUPAWG3ngG4=;
        b=W+WwYbeWzGCJ9UGnG0svIDjoDcwWL+GfjrZi1oW9wmoA0wpbyqlIidxJ0XF2VNVRvM
         /z2HfUtkAGMuEPkcVMlmevElOBsvq8g0zt9p3NzULkYFj5KNo649oPOaeWRdrfixb/37
         01lOXdErqIcaYATaiP9FDxDgyyr6Cjk8njGrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wR237/+GNxqnStiEgnNM0kyetCobpir3ZNYyD6wGTP8sK4DeYw2SU0sdBY5QXKo2S4
         lsbboX0x1M2D+nBo6Drz0ytLtQyYS9tIylqwpPqAFEVPjTgg5wqbFVrlGMzerEH0Eb+g
         2wiD3ton5+BxHs1J3edngFHHn1DND8k0P2OZE=
Received: by 10.42.52.18 with SMTP id h18mr7164599icg.443.1304997432115;
        Mon, 09 May 2011 20:17:12 -0700 (PDT)
Received: from elie (wireless-165-232.uchicago.edu [128.135.165.232])
        by mx.google.com with ESMTPS id 14sm2909158ibc.25.2011.05.09.20.17.10
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 20:17:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110510025916.GB26619@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173302>

Jonathan Nieder wrote:

>  contrib/completion/git-completion.bash |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

I forgot to list changes since v4:

 - new commit message
 - removed comment I considered unclear --- probably the following
   should be squashed in, though, to prevent someone from seeing the
   seemingly redundant "typeset -h words" and removing it, not
   realizing it is needed for compatibility with old zsh versions.

-- >8 --
From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: completion: add a comment to explain what "typeset -h words" is for

In current zsh master, bashcompinit hides the 'words' special variable
already, so our own "typeset -h words" in _git and _gitk might seem
redundant.  Add a comment to explain that it is there for
compatibility with old zsh versions.

[jn: based on the original comment by Felipe Contreras]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index da586e5..b80830e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2608,6 +2608,10 @@ _git ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# Suppress the "words" special variable from zsh.
+		# Only zsh versions <= 4.3.11 need this --- in later
+		# versions, bashcompinit takes care of it.
 		typeset -h words
 	fi
 
@@ -2660,6 +2664,10 @@ _gitk ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# Suppress the "words" special variable from zsh.
+		# Only zsh versions <= 4.3.11 need this --- in later
+		# versions, bashcompinit takes care of it.
 		typeset -h words
 	fi
 
-- 
1.7.5.1
