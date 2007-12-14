From: Wolfram Gloger <wmglo@dent.med.uni-muenchen.de>
Subject: Re: Something is broken in repack
Date: 14 Dec 2007 16:03:26 -0000
Message-ID: <20071214160326.2424.qmail@md.dent.med.uni-muenchen.de>
References: <4760E005.6040102@op5.se>
Cc: nico@cam.org, jonsmirl@gmail.com, gitster@pobox.com, gcc@gcc.gnu.org,   git@vger.kernel.org
To: ae@op5.se
X-From: gcc-return-142986-gcc=m.gmane.org@gcc.gnu.org Fri Dec 14 17:04:17 2007
Return-path: <gcc-return-142986-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J3D1F-0001M3-Tu
	for gcc@gmane.org; Fri, 14 Dec 2007 17:04:10 +0100
Received: (qmail 22156 invoked by alias); 14 Dec 2007 16:03:45 -0000
Received: (qmail 22118 invoked by uid 22791); 14 Dec 2007 16:03:43 -0000
X-Spam-Check-By: sourceware.org
Received: from zep00a03.dent.med.uni-muenchen.de (HELO md.dent.med.uni-muenchen.de) (138.245.179.2)     by sourceware.org (qpsmtpd/0.31) with SMTP; Fri, 14 Dec 2007 16:03:29 +0000
Received: (qmail 2429 invoked by uid 211); 14 Dec 2007 16:03:26 -0000
In-reply-to: <4760E005.6040102@op5.se> (message from Andreas Ericsson on Thu, 	13 Dec 2007 08:32:21 +0100)
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68313>

Hi,

> >>  	if (progress->total) {
> >>  		unsigned percent = n * 100 / progress->total;
> >>  		if (percent != progress->last_percent || progress_update) {
> >> +			struct mallinfo m = mallinfo();
> >>  			progress->last_percent = percent;
> >> -			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
> >> -				progress->title, percent, n,
> >> -				progress->total, tp, eol);
> >> +			fprintf(stderr, "%s: %3u%% (%u/%u) %u/%uMB%s%s",
> >> +				progress->title, percent, n, progress->total,
> >> +				m.uordblks >> 18, m.fordblks >> 18,
> >> +				tp, eol);
> > 
> > Note: I didn't know what unit of memory those blocks represents, so the 
> > shift is most probably wrong.
> > 
> 
> Me neither, but it appears to me as if hblkhd holds the actual memory
> consumed by the process. It seems to store the information in bytes,
> which I find a bit dubious unless glibc has some internal multiplier.

mallinfo() will only give you the used memory for the main arena.
When you have separate arenas (likely when concurrent threads have
been used), the only way to get the full picture is to call
malloc_stats(), which prints to stderr.

Regards,
Wolfram.
