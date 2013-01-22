From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] Update :/abc ambiguity check
Date: Tue, 22 Jan 2013 09:46:13 +0700
Message-ID: <CACsJy8B1uxbJvP+0ZEx3br9_Qr9ZX7num8bcgd5sFS7XnvGNpw@mail.gmail.com>
References: <1358773249-24384-1-git-send-email-pclouds@gmail.com> <7vsj5ufia6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 03:47:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxTtE-00067S-3e
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 03:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab3AVCqp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 21:46:45 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:47500 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab3AVCqo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 21:46:44 -0500
Received: by mail-ob0-f179.google.com with SMTP id x4so6504263obh.24
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 18:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=hIMbOIYDEpAWuPicbXc83KsF9K1eROIlWMLgOE+uZYU=;
        b=ZZfLN0LiXq/T4jpRJVAPMjw1fBQ1IxHxaD4aZoMA0b8wmgrKblY6DeNUsBy/fM8tyn
         iqB04ECAsgXtkK3Oj7/0eJqelJNlafXhc6NL1n45xWDhN9H822MzIgSbM1Srv2E6kPX/
         P1bF9SXK9Qj5IwvZtMtcp3zVEM1vWUcOURHlroZpxbipsHccuHRu8+I9ZR5msSzUFD/A
         yIwCdFCa/tDHSCxAMIOE2/JfdmmHY32SmuYJnG/pJOrwSw1P1Vy0G0y0dO8tC8YSKsG7
         vzumpzW2i0gB6/u6YWqouT4U/aaAc2spl8+IaVWMy5DBH7GC1FYrbZkD7l2qsRJvhcYL
         sBwA==
X-Received: by 10.60.29.66 with SMTP id i2mr15607040oeh.2.1358822803966; Mon,
 21 Jan 2013 18:46:43 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Mon, 21 Jan 2013 18:46:13 -0800 (PST)
In-Reply-To: <7vsj5ufia6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214188>

On Tue, Jan 22, 2013 at 2:27 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> :/abc may mean two things:
>>
>> - as a revision, it means the revision that has "abc" in commit
>>   message.
>>
>> - as a pathpec, it means "abc" from root.
>>
>> Currently we see ":/abc" as a rev (most of the time), but never see =
it
>> as a pathspec even if "abc" exists and "git log :/abc" will gladly
>> take ":/abc" as rev even it's ambiguous. This patch makes it:
>>
>> - ambiguous when "abc" exists on worktree
>> - a rev if abc does not exist on worktree
>> - a path if abc is not found in any commits (although better use
>
> The "any commits" above sounds very scary. Are you really going to
> check against all the commits?

If I remember correctly :/ will search through commit chains until it
finds a commit that matches. So :/non-existent-string definitely
searches through all commits.

>>   "--" to avoid ambiguation because searching through commit DAG is
>>   expensive)
>>
>> A plus from this patch is, because ":/" never matches anything as a
>> rev, it is never considered a valid rev and because root directory
>> always exists, ":/" is always unambiguously seen as a pathspec.
>
> That is the primary plus in practice, I think, and it is a big one.
>
> When naming a directory that belongs to a different subdirectory
> hierarchy, typing ":/that/directory/name" is not any easier than
> having your shell help you complete "../../that/directory/name"; I
> suspect nobody uses the relative-to-root notation to name anything
> but the root in real life.

As I noted in the patch comment, I do copy/paste repo-absolute paths
from a diff quite often (just skip the "a" and "b" prefix). Sometimes
I hope "git diff" has an option to produce relative paths..
--=20
Duy
