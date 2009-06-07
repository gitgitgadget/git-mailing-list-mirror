From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 00/23] http*: refactor (v6)
Date: Sun, 7 Jun 2009 08:41:59 +0800
Message-ID: <be6fef0d0906061741p6f3864a9m25d25e23ef0db760@mail.gmail.com>
References: <20090606164253.65a945ba.rctay89@gmail.com>
	 <7v8wk5dyrw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 02:46:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD6WO-0001L4-96
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 02:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbZFGAl7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 20:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbZFGAl6
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 20:41:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:6059 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbZFGAl5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 20:41:57 -0400
Received: by wf-out-1314.google.com with SMTP id 26so994712wfd.4
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 17:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TkHG+kfY3GKwURue9nND7nfPtTfTaVcL+8EmfzDzwJc=;
        b=i2y53d9LBAv51iVUYBtvixUI7mOUumOkHj6dnwAB3NYjXtS37S8ACf5syWLjHFLwtw
         n40cTP+fQh2+7uJNT1GdoNIoTxsf3oQGwo0YM0u2eqIxYDLrjOguV+ou+6aMCi0qhQs+
         KbtbRzpK2agDf8yYw3/NeI7U4MFDNkF07PJKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XIWt6OeyPf3LgZ+/WYxQ//wvRPIDhVdSvgtQ1G9uBqy9MnWx6XbKp4Oj7bGGN8IePF
         oOqNnsrDxuBBVVdBElYflrUc7zt6csrPB6ubdcJZeQQxszGYWpoO2JUsGmD/huZP508c
         320RmlfHuZensJEEg0lauGAhK924OBudanR7k=
Received: by 10.142.78.10 with SMTP id a10mr1991534wfb.345.1244335319987; Sat, 
	06 Jun 2009 17:41:59 -0700 (PDT)
In-Reply-To: <7v8wk5dyrw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120946>

Hi,

On Sun, Jun 7, 2009 at 2:04 AM, Junio C Hamano<gitster@pobox.com> wrote=
:
> Thanks, will queue, but please double check the result after I push i=
t
> out, as I found some other changes not listed above, relative to what=
 was
> queued in 'pu' (I am not complaining; I am asking your extra set of
> eyeballs in case I somehow screwed up applying your series to my tree=
).
>
> =A0- return value of fetch_indices() is 0 when http_get_info_packs() =
returns
> =A0 HTTP_MISSING_TARGET (both in http-push.c and http-walker.c);

This is correct. I had noted this in the patch; perhaps I should have
included it in the cover letter.

> =A0- break the function definition of run_request_queue() by removing=
 "void"
> =A0 from the parameter list ("send out fetch requests on queue" -- no=
 need
> =A0 to resend, I fixed it up again while applying);

My bad. I hadn't noticed that you've already been doing this.

> =A0- update the error checking in transport.c:get_refs_via_curl() to =
make it
> =A0 look more similar to what are in fetch_indices() in both http-pus=
h.c and
> =A0 http-walker.c.

Yes. I noted this in the patch text.

> =A0- add unused "cleanup:" label to get_refs_via_curl() in transport.=
c
> =A0 (again no need to resend, I fixed it up while applying);

Indeed. It was an uncaught consequence of the previous change.

> =A0- add back a few missing "->local =3D NULL" I screwed up while app=
lying the
> =A0 previous series.

I'll have to take a look at those.

> By the way, this is not your fault at all, but for a patch series
> description, "shortlog" is a sucky way, as we can see below. =A0When =
you
> talk about "patch #15", the reader cannot find which one you are talk=
ing
> about but has to go back to the MUA, so the list is useless for that
> purpose.

Is there a way to do this with git-format-patch? ("this" being a list
of numbered patches, instead of them being grouped by author)

--=20
Cheers,
Ray Chuan
