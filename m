From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere: fix memory leak if rerere images can't be read
Date: Tue, 23 Feb 2010 23:12:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002232312090.3980@intel-tinevez-2-302>
References: <1266955913-4943-1-git-send-email-bert.wesarg@googlemail.com>  <alpine.DEB.1.00.1002232225480.3980@intel-tinevez-2-302> <36ca99e91002231356u189b80ebka7ae8caf89ab9c10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1187285035-1266963178=:3980"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:13:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk30I-0008GH-Jc
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab0BWWNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 17:13:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:50644 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754370Ab0BWWNN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 17:13:13 -0500
Received: (qmail invoked by alias); 23 Feb 2010 22:12:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 23 Feb 2010 23:12:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1825dZVBlw2NRpEFPqJ0f7ohkE9tLTnkg8qjmyt85
	Zxr46B0rKca8ki
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <36ca99e91002231356u189b80ebka7ae8caf89ab9c10@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140855>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1187285035-1266963178=:3980
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 23 Feb 2010, Bert Wesarg wrote:

> On Tue, Feb 23, 2010 at 22:26, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Tue, 23 Feb 2010, Bert Wesarg wrote:
> >
> >> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> >> ---
> >>  rerere.c |    6 ++++--
> >>  1 files changed, 4 insertions(+), 2 deletions(-)
> >
> > Looks good to me, except...
> >
> >> diff --git a/rerere.c b/rerere.c
> >> index d1d3e75..9ca4cb8 100644
> >> --- a/rerere.c
> >> +++ b/rerere.c
> >> @@ -364,16 +364,17 @@ static int find_conflict(struct string_list *conflict)
> >>  static int merge(const char *name, const char *path)
> >>  {
> >>       int ret;
> >> -     mmfile_t cur, base, other;
> >> +     mmfile_t cur = {NULL, 0}, base = {NULL, 0}, other = {NULL, 0};
> >>       mmbuffer_t result = {NULL, 0};
> >>
> >>       if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
> >>               return 1;
> >>
> >> +     ret = 1;
> >
> > This initialization can come earlier, at declaration time.
> I thought about it, but I think it is clearer to put just in front of
> the condition which may fail.

Well, to _this_ developer, it is clearer when a variable has been 
initialized in any case. No need to think about how it could be used 
uninitialized. But if you insist...

Ciao,
Dscho

--8323329-1187285035-1266963178=:3980--
