From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv2] parse-options: report uncorrupted multi-byte options
Date: Tue, 12 Feb 2013 08:21:24 +0700
Message-ID: <CACsJy8BByNnEhhE3TieM_kOy65t75rmB45ZzjJJ8AtL2N4-UFA@mail.gmail.com>
References: <1360624428-4728-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	matthieu.moy@grenoble-inp.fr, tboegi@web.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 02:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U54Ze-0006BV-PS
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 02:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920Ab3BLBVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 20:21:55 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:57693 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675Ab3BLBVy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 20:21:54 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so6979689oag.26
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 17:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gd/SNUWKBbB8GHnRbQgrEaEgtPFXi3oTxSRIA/hemH4=;
        b=EO/7vqp328L3lU8N50Cg4VMsKwZKv4gqyWhsnqj/P08G9Epa7Ok0wONTaphnL4Q5N4
         fS3dswHRJbzGnNM1guHjZSUQv1j2JiNz/y1srhNLYF/C69s0vQ0zmhoJ+O+306aDVB2O
         UNsix2ZlUcay+KyqK8bBIO2g3rkUzLin75L2EyZjNtJ8dWGtcKYEpSquVJyMH1S68Qt8
         Q+6Ju4oU4ZMPZQ9kxUhFjViHzkqSIuIv6cqlJuMFat18kfwaXJja8JvLVv1EwTgzi1PL
         CKqHGVnAuoTudS9z4DMXqOJRMMmf+YYZ1HiLr4pkH6kfUjn+SIePODsTQU0T1eBPMEdG
         yLLg==
X-Received: by 10.60.20.7 with SMTP id j7mr12267466oee.40.1360632114240; Mon,
 11 Feb 2013 17:21:54 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Mon, 11 Feb 2013 17:21:24 -0800 (PST)
In-Reply-To: <1360624428-4728-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216109>

On Tue, Feb 12, 2013 at 6:13 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> Because our command-line parser considers only one byte at the time
> for short-options, we incorrectly report only the first byte when
> multi-byte input was provided. This makes user-erros slightly
> awkward to diagnose for instance under UTF-8 locale and non-English
> keyboard layouts.
>
> Make the reporting code report the whole argument-string when a
> non-ASCII short-option is detected.

Similar cases:

config.c:git_default_core_config() assumes core.commentchar is ascii.
We should catch and report non-ascii chars, or simply accept it as a
string.

builtin/update-index.c:cmd_update_index(): error("unknown switch
'%c'", *ctx.opt);

builtin/apply.c:apply_one_fragment(): error(_("invalid start of line:
'%c'"), first); where 'first' may be a part of utf-8 from a broken
patch.
-- 
Duy
