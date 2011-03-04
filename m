From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 4 Mar 2011 11:18:01 -0800
Message-ID: <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
References: <4D70EBC3.3010400@colin.guthr.ie> <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org> <7v39n27llq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Colin Guthrie <gmane@colin.guthr.ie>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 20:19:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvaXL-0005nJ-3f
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 20:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760059Ab1CDTTd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 14:19:33 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43864 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759886Ab1CDTTc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 14:19:32 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p24JJWSv020896
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 4 Mar 2011 11:19:32 -0800
Received: by iyb26 with SMTP id 26so2172895iyb.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 11:19:31 -0800 (PST)
Received: by 10.43.54.147 with SMTP id vu19mr965181icb.329.1299266371794; Fri,
 04 Mar 2011 11:19:31 -0800 (PST)
Received: by 10.231.15.197 with HTTP; Fri, 4 Mar 2011 11:18:01 -0800 (PST)
In-Reply-To: <7v39n27llq.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-103.481 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168461>

On Fri, Mar 4, 2011 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> And here is a quick and dirty fix to do something like that. =A0It as=
sumes
> that the hunks for a single file being patched are already sorted in =
the
> ascending order (which should be the case), and may regress cases whe=
re we
> used to find a match even when the version you are patching has moved
> functions around in the file by failing to notice a match. =A0And it =
does
> get the same result as your GNU patch test.

Ack. Looks correct. In fact, shouldn't we make that "last_match" be
the _end_ of the last place we applied the patch at, rather than the
beginning?

IOW, maybe something like "img->last_match =3D applied_pos +
postimage.nr;" or whatever.

I dunno.

                     Linus
