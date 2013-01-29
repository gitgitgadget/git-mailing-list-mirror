From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Tue, 29 Jan 2013 18:01:38 +0700
Message-ID: <CACsJy8AHEyQ5-qz9auB3vT_Esmos2t-cRhtvf3zbVJDMFRET_A@mail.gmail.com>
References: <20130126224011.GA20675@sigill.intra.peff.net> <7vlibfxhit.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 12:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U08xU-0000hw-QD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 12:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884Ab3A2LCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 06:02:10 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35349 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab3A2LCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 06:02:09 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so276247obb.11
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 03:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YyDabLqvywvNDbZtkyeMXn6xD5uzYstPDu1Zm1jSOGE=;
        b=aaILvrKUHDc+uBnMtlD24PN5h9Oc9Y/PFtQXGKZufY71IYFNr/mvVIRbaZn4hOkcnV
         K+r2Xyn+pRTuhblHpw4UVKTnkpO44gp5FrEDsLKZHskx+i58tExfRMpd3Ua9eGtUx3qF
         ngEYal9Z+dhrLXzTxdgU1ARXThDAPaT4qSPLG4w1viMGYJ9eIBfYB0nR82ALbl9JRE5P
         eGFnbuwZf55P3aTMjdx7AwFpric49KHkdiKVNay94e62wXuygBKwGE1cO6SxrnDlARZJ
         BcCBLUc16i1ZR1UDQ3TbtEn6BkJiaoP7tRLMhXMxaJJjSEnXleY+hMDzCj1lXl3r+6PY
         kxFQ==
X-Received: by 10.60.3.1 with SMTP id 1mr343706oey.138.1359457328953; Tue, 29
 Jan 2013 03:02:08 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Tue, 29 Jan 2013 03:01:38 -0800 (PST)
In-Reply-To: <7vlibfxhit.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214927>

On Sun, Jan 27, 2013 at 1:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I also wonder if we would be helped by another "repack" mode that
> coalesces small packs into a single one with minimum overhead, and
> run that often from "gc --auto", so that we do not end up having to
> have 50 packfiles.
>
> When we have 2 or more small and young packs, we could:
>
>  - iterate over idx files for these packs to enumerate the objects
>    to be packed, replacing read_object_list_from_stdin() step;
>
>  - always choose to copy the data we have in these existing packs,
>    instead of doing a full prepare_pack(); and
>
>  - use the order the objects appear in the original packs, bypassing
>    compute_write_order().

Isn't it easier and cheaper to create the "master index", something
like bup does?
-- 
Duy
