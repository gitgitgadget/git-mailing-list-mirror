From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t3404: restore specialized rebase-editor following
 commentchar test
Date: Mon, 12 Aug 2013 03:29:04 -0400
Message-ID: <CAPig+cQpNTFr91wp8DxYs3tabmj4xdmqTQ4_ZoNhp-4+0BUKCA@mail.gmail.com>
References: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
	<1376280459-55188-2-git-send-email-sunshine@sunshineco.com>
	<7v4nav1kzx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, David <bouncingcats@gmail.com>,
	Diogo de Campos <campos@esss.com.br>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:29:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8mYy-0003pf-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab3HLH3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 03:29:08 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:60107 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab3HLH3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 03:29:06 -0400
Received: by mail-la0-f50.google.com with SMTP id fn20so4418909lab.9
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 00:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=eKh1hEJAxRu9Vzs49Qh3wgCXs3Mnf8SkqgZK9ffbTbs=;
        b=Gs6rMKIFBbZ/1LurBXdRkth36pMuXOIhDue0arAwTFOWS2i0B3dVwa1opn64ECm8ne
         sFp8HENsOpJmkBAjDOiKlPMCfW5sHC965yoQckXLK+BsBpXnq+YjII+5kgJ2zTIHIU1V
         g8Ay8xwr//PlgHqHpoOuFvwtlj4MTTWHp8lvqr+HbOkWhWPu35z+cD2UPulMxiMUIRMI
         9jHVVGFUYQcBnM4iboHVOSnhbUD6HWW8jkj2gQSVTX3Ny4FauUhHvjUYLiTSyhpjGQwR
         OauT0B0T3MEuN0dJWAlQHNzJbZ5AzrR5ioB5Do+NJs3G1owWF8oSsdtU5PltXUKUsD/F
         2XJA==
X-Received: by 10.152.4.201 with SMTP id m9mr10581413lam.86.1376292544292;
 Mon, 12 Aug 2013 00:29:04 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 12 Aug 2013 00:29:04 -0700 (PDT)
In-Reply-To: <7v4nav1kzx.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 16vmWSqoZJ_d_aoaBnh4dTdZXvI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232164>

On Mon, Aug 12, 2013 at 2:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> At start of script, t3404 installs a specialized test-editor ($EDITOR)
>> upon which many of the interactive rebase tests depend.  Late in t3404,
>> test "rebase -i respects core.commentchar" installs its own custom
>> editor but neglects to restore the specialized editor when finished.
>> This oversight will cause later tests, which require the specialized
>> editor, to fail.
>
> That is not oversight but was deliberately done knowing that it will
> be the last test (and new tests can be added before it).

There is no mention of this being deliberate either in the mailing
list discussion [1] or the commit message (180bad3d1), and other tests
have been added following this one.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/216079

> I think the patch is one way to give _known_ status to later tests
> by declaring the editor installed by "set_fake_editor" the gold
> standard, but isn't a better alternative to make sure that any newly
> added tests after this point (or before the commentchar tests, for
> that matter) set a fake editor it wants to use explicitly?

set_fake_editor is the very first thing done by t3404, and many tests
depend upon this state. It would have been inconsistent for this one
new test to be the exception by having to invoke set_fake_editor
itself, however, I don't mind making the new test more self-contained,
despite the inconsistency. (A later cleanup patch can do the same for
other existing tests.)
