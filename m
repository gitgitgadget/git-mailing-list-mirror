From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 06/15] remote-testgit: get rid of non-local functionality
Date: Thu, 22 Nov 2012 00:44:44 +0100
Message-ID: <CAMP44s1CH4Ay=Z5oq18UXwPk3iDH1V2uzA_C0wNDw6d87JV-vA@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-7-git-send-email-felipe.contreras@gmail.com>
	<7v624y3h0q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:00:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbc0u-0001Z1-Ap
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab2KVTAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:00:18 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62532 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410Ab2KVTAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:00:15 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8296901oag.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=c/C8VWfo7BB6/MLwBJwAbNVX1J9bjNwIA1j92nE7qEw=;
        b=FGAi+2/hgL7wiET1b80DOK7xKdpyaUVlN4VG/nJnePqT2snxSupTxFtL3ROBOWq60X
         Puca4GGoK22hs0s5TyD0apYMBNvxt+IHd2V3+hrZsw6EaJ3ghHoGyCpX9hQfTU/i3hXT
         ml1lbkvUaps4RrCPxsVmIooEYSXneLTAzeuPZIk/y5xQmSg8/okrxgSBD+hW7yZgb2/P
         D6t3D3J9Ed8s2u64NYaX7jP16NgcrfwiObPR4F5998MPVUepDQTXj5qb1JLEzMIhByfn
         LGZSm9qLTCyiCiXprRSw6xv0aT6tIfnVR0Pe9RN7Ir0NhQfPrQqkUsJ+RDJgjhtYxRTH
         b6iw==
Received: by 10.60.31.6 with SMTP id w6mr1873452oeh.65.1353541484528; Wed, 21
 Nov 2012 15:44:44 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 21 Nov 2012 15:44:44 -0800 (PST)
In-Reply-To: <7v624y3h0q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210186>

On Wed, Nov 21, 2012 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This only makes sense for the python remote helpers framework.
>
> A better explanation is sorely needed for this.  If the test were
> feeding python snippet to be sourced by python remote helper to be
> tested, the new remote-testgit.bash would not have any hope (nor
> need) to grok it, and "this only makes sense for python" makes
> perfect sense and clear enough, but that is not the case.
>
> If the justification were like this:
>
>     remote-testgit: remove non-local tests
>
>     The simplified remote-testgit does not talk with any remote
>     repository and incapable of running non-local tests.  Remove
>     them.
>
> I would understand it, and I wouldn't say it is a regression in the
> test not to test "non-local", as that is not essential aspect of
> these tests (we are only interested in testing the object/ref
> transfer over remote-helper interface and do not care what the
> "other side" really is).
>
> But I am not quite sure what you really mean by "non-local"
> functionality in the first place.  The original test weren't opening
> network port to emulate multi-host remote transfer, were it?

No, that's not it at all.

By local, I mean 'file:///home/user/foo', by remote, I mean
'http://user.org/foo'. How each of these URLs is handled is entirely
up to the remote helper.

bzr for example doesn't need any change at all, the same API works on
both cases. hg OTOH has different APIs, so the code needs a local
clone to do most operations. The python remote helper framework has
APIs to make it easier to implement the local clone functionality (for
the remote helpers that need it).

This has absolutely nothing to do with with remote helpers, this is
100% a python remote helper feature. So we don't need those tests
here, they belong in git-remote-testpy.

Cheers.

-- 
Felipe Contreras
