From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/5] merge_recursive: Fix renames across paths below D/F 
	conflicts
Date: Wed, 30 Jun 2010 08:53:19 +0200
Message-ID: <AANLkTilJIh9V3kIhBnfm5Bunzbp7XdoYOOoVbku_u-8y@mail.gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
	<1277773936-12412-5-git-send-email-newren@gmail.com>
	<20100629075442.GB31048@genesis.frugalware.org>
	<AANLkTimFBlWiK76quLW1TiUfueGISsW7ZIHgFUcFg4j8@mail.gmail.com>
	<AANLkTil7CdCoP3wLVKX0MEiwp8KaKWFLvRtUWzt2a3Nh@mail.gmail.com>
	<AANLkTilggM9-vBabNvJiYMiQZyZtJMLhfWleYKvuJNMv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, gitster@pobox.com, spearce@spearce.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 08:53:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTrAm-0003O8-1V
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 08:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab0F3GxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 02:53:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64868 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab0F3GxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 02:53:21 -0400
Received: by ewy23 with SMTP id 23so101297ewy.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 23:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ul0RHdoj2RPOuY5qAWciRTplhDyWToF6FlKmTmepDho=;
        b=NXwTarNHVw7zXLlQtiep15QVdGGqX5eoAk367L/eJ2CkxoeD1dtoTrLJwFJeC9K1B9
         UZnBeS4RgFz2r4x6csAxj5MvO9rPQlk8aoMUdcN3QPqd2zn6EFE6lZtbOfbMlO5qMzRa
         xhRkYDW6dHjkdouNlwCsRq/iVHEq+tyJVcZsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OKX7cnlazys5NAwMzBubfbfdVYAMXq/Bm/BheU9jnmoEdFxdZ1Y+Cj5/5tnzjx5cvz
         wBI5QlVio6IFqSjLHRZl5TQRH5WhhCiUQbNfIURqfEj+mGUPqHRsafDWIaxNk/xwFKGg
         bOHPysiGt5jqzwzPga1Ce340hGGwoJ4ylzx9g=
Received: by 10.213.22.201 with SMTP id o9mr109064ebb.89.1277880799847; Tue, 
	29 Jun 2010 23:53:19 -0700 (PDT)
Received: by 10.213.105.148 with HTTP; Tue, 29 Jun 2010 23:53:19 -0700 (PDT)
In-Reply-To: <AANLkTilggM9-vBabNvJiYMiQZyZtJMLhfWleYKvuJNMv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149948>

On Tue, Jun 29, 2010 at 17:55, Elijah Newren <newren@gmail.com> wrote:
> On Tue, Jun 29, 2010 at 7:36 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>> I cannot say much about your change... Are you sure about D/F conflict
>> detection, though? You just test if target mode not 0.
>
> Well, as far as this particular if-block is concerned, blame suggests
> that you and Miklos were responsible (I apologize if gmail screws up
> and inserts line wrapping)::

Don't just look at the blame output, look at what the commits actually changed.
It's either a reformatting or a trivial change.

> With D/F conflicts, the files would be loaded into higher stages in
> the index (before it gets to process_renames()), which I detected via
> a non-zero mode.

This just detects if there was any conflict. Not specifically D/F or F/D.

> If there's a different way I should be checking for higher stage entries
> that still need to be resolved, I'd be happy to use it.

I'd expect a check for a file-to-directory (or back) mode change.
