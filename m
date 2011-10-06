From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 5 Oct 2011 20:08:38 -0400
Message-ID: <CAG+J_DxJ25bBo0=30+9r3+kwy+u4M9ZdihnctsMYis+zgbduEg@mail.gmail.com>
References: <4E8C6F2F.1070306@6wind.com>
	<7v8voz8hgq.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dyn3kk7SfNZzxjoD-hK9jBQr2igmOqJojeYNHLubtSY=w@mail.gmail.com>
	<7vpqib5ciw.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dysix9fOCuvm5+aU7-AC4wmsxH4-MOX+yhaHEqzeN1cPg@mail.gmail.com>
	<7vhb3n5asv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 02:08:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBbW0-00066h-TA
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 02:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935582Ab1JFAIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 20:08:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48314 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935579Ab1JFAIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 20:08:39 -0400
Received: by ywb5 with SMTP id 5so2105940ywb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 17:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O7u6docthyNtNun4DS/T5nM7xEUbBfBG2KNdlDG6Rq4=;
        b=R7xnvwI4Z1amxihYPmi2Vom86T32kNHCWClgglcaFjeVu9qQmHPeTJu/vcFBQ4c27m
         xVM541rML3a/0V4iKVIhko50v9ijJrlpVio7+Jbw8bgB5odff1ZrHvurQrz45u5Cf6tk
         LbgEGKBAG99h9zFC5V1jU7UZTCbe3NjZE9Cb4=
Received: by 10.236.183.170 with SMTP id q30mr338389yhm.42.1317859718855; Wed,
 05 Oct 2011 17:08:38 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 17:08:38 -0700 (PDT)
In-Reply-To: <7vhb3n5asv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182905>

On Wed, Oct 5, 2011 at 6:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Does it also refrain from creating sequencer state directory?

I'm not familiar with the sequencer code. It's not in master is it?

What's happening here is that do_pick_commit() was creating
CHERRY_PICK_HEAD, but then git aborts several call sites away
(do_recursive_merge -> merge_trees -> git_merge_trees -> unpack_trees
-> display_error_msgs).

So I think do_pick_commit() needs to defer creating CHERRY_PICK_HEAD
till after the possible abort.

I don't know if that's the right fix for next or not, but it seems
correct for master.

j.
