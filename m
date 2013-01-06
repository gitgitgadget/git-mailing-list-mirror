From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 02/19] Improve documentation and comments regarding
 directory traversal API
Date: Sun, 6 Jan 2013 12:02:01 +0000
Message-ID: <20130106120201.GH28089@pacific.linksys.moosehall>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-3-git-send-email-git@adamspiers.org>
 <7vobh8aans.fsf@alter.siamese.dyndns.org>
 <CAOkDyE_DX8iAAd5ubJaQ_guPQ-PSz4-sFETZoRf7JRTrH6Qcpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 13:02:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trovn-0007hb-T7
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 13:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929Ab3AFMCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 07:02:06 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45182 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806Ab3AFMCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 07:02:03 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 99DF22E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 12:02:01 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAOkDyE_DX8iAAd5ubJaQ_guPQ-PSz4-sFETZoRf7JRTrH6Qcpw@mail.gmail.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212796>

On Wed, Jan 02, 2013 at 12:54:19PM +0000, Adam Spiers wrote:
> On Tue, Jan 1, 2013 at 8:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Adam Spiers <git@adamspiers.org> writes:
> >> diff --git a/dir.c b/dir.c
> >> index ee8e711..89e27a6 100644
> >> --- a/dir.c
> >> +++ b/dir.c
> >> @@ -2,6 +2,8 @@
> >>   * This handles recursive filename detection with exclude
> >>   * files, index knowledge etc..
> >>   *
> >> + * See Documentation/technical/api-directory-listing.txt
> >> + *
> >>   * Copyright (C) Linus Torvalds, 2005-2006
> >>   *            Junio Hamano, 2005-2006
> >>   */
> >> @@ -476,6 +478,10 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
> >>               die("cannot use %s as an exclude file", fname);
> >>  }
> >>
> >> +/*
> >> + * Loads the per-directory exclude list for the substring of base
> >> + * which has a char length of baselen.
> >> + */
> >>  static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
> >>  {
> >>       struct exclude_list *el;
> >> @@ -486,7 +492,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
> >>           (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
> >>               return; /* too long a path -- ignore */
> >>
> >> -     /* Pop the ones that are not the prefix of the path being checked. */
> >> +     /* Pop the directories that are not the prefix of the path being checked. */
> >
> > The "one" does not refer to a "directory", but to an "exclude-list".
> 
> No, if that was the case, it would mean that multiple exclude lists
> would be popped, but that is not the case here (prior to v4).

Sorry, I meant prior to v3 11/19.

> >         Pop the ones that are not for parent directories of the path
> >         being checked
> 
> Better would be:
> 
>     Pop the entries within the EXCL_DIRS exclude list which originate
>     from directories not in the prefix of the path being checked.
> 
> although as previously stated, the v4 series I have been holding off
> from submitting (in order not to distract you from a maint release)
> actually changes this behaviour so EXCL_DIRS becomes an exclude_group of
> multiple exclude_lists, one per directory.  So in v4, multiple
> exclude_lists *will* be popped.  I'll tweak the comment in v4 to make
> this clear.

Again, I got confused and forgot that I already included the switch to
exclude_list_groups as v3 11/19.  But since the patch being discussed
here is v3 02/19 which precedes it, everything I said still applies.
