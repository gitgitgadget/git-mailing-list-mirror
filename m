From: Drew Northup <drew.northup@maine.edu>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 07 Oct 2010 14:02:31 -0400
Message-ID: <1286474551.15999.9.camel@drew-northup.unet.maine.edu>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
	 <20101007141015.GB8162@sigill.intra.peff.net>
	 <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
	 <4CADE232.8030801@viscovery.net>
	 <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
	 <20101007172939.GA12130@sigill.intra.peff.net>
	 <vpqy6a952bh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3uob-0004S3-DK
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab0JGSD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 14:03:26 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:34302 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab0JGSD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 14:03:26 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o97I2b9W002516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 Oct 2010 14:02:37 -0400
In-Reply-To: <vpqy6a952bh.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o97I2b9W002516
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1287079364.46622@EOxgmbX5ND2J3yG6RgUEcQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158420>


On Thu, 2010-10-07 at 19:40 +0200, Matthieu Moy wrote:
> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index efe9360..3b2dca0 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -147,8 +147,10 @@ static void show_commit(struct commit *commit, void *data)
> >  			}
> >  		} else {
> >  			if (revs->commit_format != CMIT_FMT_USERFORMAT ||
> > -			    buf.len)
> > -				printf("%s%c", buf.buf, info->hdr_termination);
> > +			    buf.len) {
> > +				fwrite(buf.buf, 1, buf.len, stdout);
> > +				putchar(info->hdr_termination);
> > +			}
> >  		}
> >  		strbuf_release(&buf);
> >  	} else {
> 
> Sounds like a sane thing to do, yes.

Agreed. I could have sworn that printf() used standard C-strings which
terminate with %x00!

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
