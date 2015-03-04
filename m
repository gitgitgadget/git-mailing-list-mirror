From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: [PATCH] Use unsigned char to squash compiler warnings
Date: Wed, 4 Mar 2015 17:34:23 -0500
Message-ID: <002301d056cb$5d86f5a0$1894e0e0$@nexbridge.com>
References: <1425324151-5480-1-git-send-email-bdwalton@gmail.com>	<xmqqoaob9m82.fsf@gitster.dls.corp.google.com>	<CAP30j1684A=QsA0o+zLMP70V09mFTS_MtiPZB2TrRywYK2NWWw@mail.gmail.com> <xmqqd24o76rh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Ben Walton'" <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 23:34:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTHs8-0004KV-6C
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 23:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbbCDWe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 17:34:27 -0500
Received: from elephants.elehost.com ([216.66.27.132]:33855 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbCDWe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 17:34:27 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t24MYMdQ090780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 4 Mar 2015 17:34:23 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <xmqqd24o76rh.fsf@gitster.dls.corp.google.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQF/z5IuPpvI9hlvF7LhzshN6OC42wEiWPm8AligOzEBwRsOyJ2EEw1Q
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264792>

>On 4 Mar 2015, Junio C Hamano Wrote:
> Sent: March 4, 2015 5:11 PM
> To: Ben Walton
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] Use unsigned char to squash compiler warnings
> 
> Ben Walton <bdwalton@gmail.com> writes:
> 
> > On Mon, Mar 2, 2015 at 8:30 PM Junio C Hamano <gitster@pobox.com>
> wrote:
> >
> >> The conversion looked good from a cursory view; I didn't check it
> >> very carefully though.
> >>
> > Yes, because of the Solaris ABI, the Studio compiler defaults char to
> > signed char.
> 
> Doesn't our beloved GCC also uses signed char when you write char?
> You keep saying that "defaults to signed char is the problem", but that
does not
> explain why those in the rest of the world outside the Solaris land do not
> encounter this problem.
> 
> 	$ cat >x.c <<\EOF
>         #include <stdio.h>
>         int main (void) {
>                 SIGNED char ch = 0xff;
>                 printf("%d\n", ch);
>                 return 0;
>         }
> 	EOF
>         $ gcc -Wall -DSIGNED= x.c && ./a.out
>         -1
>         $ gcc -Wall -DSIGNED=signed x.c && ./a.out
> 	-1
> 
> I think th problem is not Solaris uses signed char for char like everybody
else
> does ;-) but it gives a fairly useless warning to annoy people.
> 
> In any case, here is what I queued, FYI, on bw/kwset-use-unsigned topic.

Even the NonStop c99 compiler does not report a warning - and it is usually
very noisy. The default is unsigned char for c99 on this platform, and the
value interpretation is significant.

#include <stdio.h>

int main (void) {
        char ch0 = 0xff;
        signed char ch1 = 0xff;
        unsigned char ch = 0xff;
        printf("%d, %d, %d, %d, %d\n", ch0, ch, ch1, ch==ch0, ch==ch1);
        return 0;
}
255, 255, -1, 1, 0
