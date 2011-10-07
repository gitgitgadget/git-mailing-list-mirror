From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH WIP 0/3] git log --exclude
Date: Fri, 7 Oct 2011 18:16:04 +1100
Message-ID: <CACsJy8DJs_cmCZegyPk=tB-bxWp4izrsTn8T=xeV1sU4fS5oTQ@mail.gmail.com>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com> <7vhb3n8ie9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 09:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC4fg-0007QP-Tf
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 09:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621Ab1JGHQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 03:16:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47783 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab1JGHQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 03:16:35 -0400
Received: by bkbzt4 with SMTP id zt4so4503503bkb.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3isCD8+TXMtNgSjbNNWpV2VWPX5JydQxgpmLHK45t74=;
        b=JnckL9iahFoCQBvBNGaRAFdO9od8roOT3zqnPpneA8VsGnPYIqAEivRlE0NWco/uxt
         NxXe8/9ATCoh0CWmA2n62bD8iYZgdUUCMWNyHczaFXbAvVyYimf+/TlzFmb0Cl8qh4+r
         0eginrA1HuOCurARo95ze31iaZtj09Fh0UEho=
Received: by 10.204.6.210 with SMTP id a18mr1083580bka.303.1317971794158; Fri,
 07 Oct 2011 00:16:34 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Fri, 7 Oct 2011 00:16:04 -0700 (PDT)
In-Reply-To: <7vhb3n8ie9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183063>

2011/10/6 Junio C Hamano <gitster@pobox.com>:
> For the purpose of "log --exclude" [*2*], I do not mind too much if t=
he UI
> expressed negative pathspecs using such a new command line option, bu=
t I
> think it would be more natural to say (notations aside):
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git log -- ':(no):po' .
>
> and define the behaviour of user-supplied pathspec limiter this way:
>
> =C2=A0* Paths are matched from left to right;
>
> =C2=A0* First match determines the fate of the path;
>
> =C2=A0* A match with negative pathspec means "the path in question do=
es _not_
> =C2=A0 match".

Things have changed a bit since last time I touched negative pathspec.
Because of depth limit support [1], pathspecs have to be sorted, which
means we cannot keep pathspec in original order to match from left to
right.

There may be a solution to mix depth limit and negative pathspec. I
haven't thought carefully about that because I lean towards a simpler
behaviour that only allows one negation level: a file is in if it
matches any positive pathspecs and none of negative ones.

This is enough if narrow clones consist of positive pathspec only. I
really doubt if users would want to make a narrow clone that "contains
A but not A/B, storage-wise".

[1] 86e4ca6 (tree_entry_interesting(): fix depth limit with
overlapping pathspecs)
--=20
Duy
