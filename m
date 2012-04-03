From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCHv1 2/2] git-p4: import/export of labels to/from p4
Date: Tue, 3 Apr 2012 23:52:47 +0100
Message-ID: <20120403235247.02c85147@fenix.utopia.dhis.org>
References: <1333438715-14902-1-git-send-email-luke@diamand.org>
	<1333438715-14902-3-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCb8-0006an-J8
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765Ab2DCWxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:04 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40973 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab2DCWxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:03 -0400
Received: by wgbdr13 with SMTP id dr13so182102wgb.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=8fcFlPQK/aiPLnqTbdL0YukeKpTM5CX41mRUGBX0M7U=;
        b=Q1UJPwWnSnPaEbzhrsQ0E/hBCdiLeK6+xH6xwTlAe4rlR+9rBzeK+AsSvwsn0lZVIB
         VOmn9ObtaICm2pFUA4V0lejdmiAU85bsxUWechbAjg1+YuAnuPfOBv/pjeLhaCqWJa1X
         7yJmTfHzSxao7jaRNopPl8XUuQyS5sNXzvaCu2KJvwQ0n92C/N17uqoje4MqPanmlYgH
         OeXhYlQUHSQempK8vJ7SGgWAZABm0knd2ClvUphKIy5h8RVlZacJ77Ud7A4GP6LNK51R
         vg597FBR9KXN5jLsDi42U1qdwpbZ/+kwATIVcdHUI8rdKLdp0Umgg1tZMyQB6cQHe9Tn
         FcNg==
Received: by 10.180.101.136 with SMTP id fg8mr11060168wib.4.1333493581573;
        Tue, 03 Apr 2012 15:53:01 -0700 (PDT)
Received: from fenix.utopia.dhis.org (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id 9sm75269316wid.2.2012.04.03.15.53.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 15:53:00 -0700 (PDT)
In-Reply-To: <1333438715-14902-3-git-send-email-luke@diamand.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194659>

On Tue,  3 Apr 2012 08:38:35 +0100
Luke Diamand <luke@diamand.org> wrote:

> The existing label import code looks at each commit being
> imported, and then checks for labels at that commit. This
> doesn't work in the real world though because it will drop
> labels applied on changelists that have already been imported,
> a common pattern.
> 
> This change adds a new --import-labels option. With this option,
> at the end of the sync, git-p4 gets sets of labels in p4 and git,
> and then creates a git tag for each missing p4 label.
> 
> This means that tags created on older changelists are
> still imported.
> 
> Tags that could not be imported are added to an ignore
> list.
> 
> The same sets of git and p4 tags and labels can also be used to
> derive a list of git tags to export to p4. This is enabled with
> --export-tags.
> 
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  Documentation/git-p4.txt       |   39 ++++++-
>  contrib/fast-import/git-p4     |  249
> ++++++++++++++++++++++++++++++++++------ t/t9811-git-p4-label-import.sh
> |  145 +++++++++++++++++++++++ 3 files changed, 398 insertions(+), 35
> deletions(-) create mode 100755 t/t9811-git-p4-label-import.sh
> 

Would it be possible to only export git tags during commit?

I don't think it is intuitive to make changes in P4 during sync operation.
And because it is possible to configure git-p4 to always export tags it will
be easy to forget that while sync'ing we are also updating P4.

I still did not test the patch in my branch environment, so I may have more
updates later. But for now, everything else seems ok by me.

Vitor
