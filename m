From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 4 Apr 2012 20:50:40 +0800
Message-ID: <CALUzUxoOcncBnMcuA0hGzu=1P=8e7GbqoNNFO7M584YGDKYPRQ@mail.gmail.com>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
	<1332966017-6100-1-git-send-email-kusmabite@gmail.com>
	<7viphotng8.fsf@alter.siamese.dyndns.org>
	<7vaa30tmk9.fsf@alter.siamese.dyndns.org>
	<7v62dotltk.fsf@alter.siamese.dyndns.org>
	<20120329054558.GA27604@sigill.intra.peff.net>
	<CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com>
	<7v398mgfdu.fsf@alter.siamese.dyndns.org>
	<20120404094618.GA13870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	hellmuth@ira.uka.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 14:50:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFPfi-000521-OC
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 14:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756290Ab2DDMum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 08:50:42 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38604 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab2DDMul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 08:50:41 -0400
Received: by wgbdr13 with SMTP id dr13so239266wgb.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3YJ98ooYXKT8lvkwLhVU0FmyIG19L5u7RypGzG6Wg2I=;
        b=AuZ66N+F3ViaE2z51LyzF9bbV8+7my89aSLm9U+xFqCrlVvp0Kjs1ppfE7xLNOnh81
         6xWmjw7DOKbAqZbh8iZQP1Ybs1AwBI5gfS0XfY/eCZ3fI2rbGXxJQWEaMqu+H2dLBkxU
         x+fEvI5j9u2nNEgUWLj+tpap2LUeRnTwUdFEcLjo8GwdMC2G+s79RDPmQsX/mPIY+60c
         JpaK2Y7mk6SKWJh05s7Czuv4hvIZj3ZO59lMBkRgke66FHF3yJ7J/30rT9qEm1WsqJdp
         UGrmMnR1dcxcdDhOKCHBBTvLua6L8Cg6uoHN6fCkmKSEGgP4CHitHb22470vfwXw0du7
         yqLA==
Received: by 10.216.131.24 with SMTP id l24mr1351497wei.76.1333543840221; Wed,
 04 Apr 2012 05:50:40 -0700 (PDT)
Received: by 10.223.134.76 with HTTP; Wed, 4 Apr 2012 05:50:40 -0700 (PDT)
In-Reply-To: <20120404094618.GA13870@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194698>

On Wed, Apr 4, 2012 at 5:46 PM, Jeff King <peff@peff.net> wrote:
> I do still think it would be nicer to pass the information out to the
> caller instead of just filtering. So combining the two patches, we have
> something like:

Thanks Maestros! This has been bugging me for some time.

I gave the combined patch a shot with a trivial conflict, and it gave
me "Only binary files changed". Turns out this only happens with a
tree that has a only conflicted files; with a tree that has a mixed of
conflicted and modified paths, it doesn't show up.

Below is a quick and dirty fix:

-->8--
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 28d36f7..96f12ca 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1207,6 +1207,7 @@ sub patch_update_cmd {

        print colored $error_color, "ignoring unmerged: $_->{VALUE}\n"
                for grep { $_->{UNMERGED} } @mods;
+       @all_mods = grep { !$_->{UNMERGED} } @all_mods;
        @mods = grep { !$_->{UNMERGED} } @mods;

        if (!@mods) {
--

-- 
Cheers,
Ray Chuan
