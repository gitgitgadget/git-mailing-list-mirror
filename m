From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT RFC] Commit behaviour
Date: Sun, 15 Jun 2008 04:00:53 +0200
Message-ID: <485477D5.3090502@gmail.com>
References: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com> <4852EFBF.6000406@gmail.com> <200806141223.11134.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 04:02:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7hZA-0002Vg-6A
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 04:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbYFOCBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 22:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755391AbYFOCBE
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 22:01:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:58286 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321AbYFOCBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 22:01:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3050808fgg.17
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 19:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=hRpHzncFdRff+zH+FvsmlO190d4oRjduhspAG/JwU7M=;
        b=wwpfguLsCiMzFJ3RYDO2dcSOWhLVhcAsk9itPRHWZu5GYtXQPZRcjUvN1jl2yEsoeC
         vB83JODClXqi3fASYZ9uCkP9a6d8xju34HRGQVMke9Zq5NldZoI8QrHe2QPaJg1eu+/W
         6yD59dXvT6R93XgbfRJTsZRBTrJ6xFvDiRuiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=T92WdN9NVgjf4f418dqkr4nkT0MXquSmSlgnvPGKAPdPrD9mmiPdDtSJvNoXKORauS
         s9c+kI/ZHblchNZN2LGn3jEwwoZYsIg/gJPhz9VEFw9yYkzQIDxafwrKNbg/RRTE0i58
         rdUinqn39D1BCyPoG/2Ringqujh/720g/t67M=
Received: by 10.86.84.5 with SMTP id h5mr6522667fgb.58.1213495260412;
        Sat, 14 Jun 2008 19:01:00 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id d6sm9879447fga.2.2008.06.14.19.00.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 19:00:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080313 Iceape/1.1.9 (Debian-1.1.9-5)
In-Reply-To: <200806141223.11134.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85059>

Robin Rosenberg wrote:
> Found it. Obviously this won't work for commits to multiple repositories which is supposed
> to work really, but I think that was broken earlier by yours truly. This fix should make it
> possible to test the idea though this thread is about, and see if we have more selection
> problems. 
> 
> -- robin
> 
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
> index da32ea5..922649b 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
> @@ -124,7 +124,7 @@ public class CommitAction extends RepositoryAction {
>         }
> 
>         private void loadPreviousCommit() {
> -               IProject project = getSelectedProjects()[0];
> +               IProject project = getProjectsForSelectedResources()[0];
> 
>                 Repository repo = RepositoryMapping.getMapping(project).getRepository();
>                 try {
> 

Yeah, it works for me now, with this patch applied.

And yes, without this patch, I found mentioned exception in log:
java.lang.ArrayIndexOutOfBoundsException: 0
  at 
org.spearce.egit.ui.internal.actions.CommitAction.loadPreviousCommit(CommitAction.java:127)

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
