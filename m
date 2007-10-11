From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: Spam: Re: git branch performance problem?
Date: Thu, 11 Oct 2007 10:41:06 +0100
Message-ID: <e2b179460710110241i445bc61ep8ae60e421c19c0f0@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
	 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
	 <20071010213925.GB2963@fieldses.org>
	 <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com>
	 <470D585D.1030808@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lars Hjemli" <hjemli@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, hanwen@xs4all.nl,
	git@vger.kernel.org
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 11 11:42:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfuYb-00046l-T0
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 11:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbXJKJlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 05:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXJKJlK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 05:41:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:52488 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbXJKJlI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 05:41:08 -0400
Received: by wx-out-0506.google.com with SMTP id h31so515522wxd
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4W8Bq5UKnML/NgGzTQRRQcMSkLKgAjwerDKNzrCRvfA=;
        b=iC5cxBgirJL0/wuSSYO4r72aURp97HTVLwck5GCZSC37oPk3ljgS2dG2i64HALtARQdX/LCFPYA0y5iX/aMgHSga4N5QUNqGauDDtOr/zv2Rj1PbjVxVnTox1GY1KPMx8FA0JP6TqFGYIK7ZobcBjqT7c7q63rq/f1wS0b2xBGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FtN6Q64x0Ytw5pJz0xUevPrwDqszFv6trGUkZOKL9sCy/EKGK0AiMa6bltzYBKmePjpbxgeT/qNjR7NV6T+IXmUMc7p0kLIjrT/HmGIGAFpjY1bJ30tpxhTn4qzF+Vzn0eeLoLyYaPYJYtBOjzY96vQPq8UD+0Xv8lK5UNRtImo=
Received: by 10.90.86.10 with SMTP id j10mr2650316agb.1192095666473;
        Thu, 11 Oct 2007 02:41:06 -0700 (PDT)
Received: by 10.90.51.10 with HTTP; Thu, 11 Oct 2007 02:41:06 -0700 (PDT)
In-Reply-To: <470D585D.1030808@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60589>

On 10/10/07, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> No, this is not the case, unless something has changed very recently
> in git-gc or git-repack. Even git-gc with no arguments is unsafe if
> the repository being gc'ed is listed in another's alternates.
>
> git-gc calls repack with -a and -d. which causes a new pack to be
> created which only contains the objects required by the local repository.
> The other packs are then deleted. Objects contained in those packs and
> required by a "sharing" repository (one using the alternates mechanism)
> will be deleted if the local repository no longer references them.

It's not something I've really looked into, but there seems to be a
reflogs mechanism which can temporarily pin an otherwise unreferenced
object so it doesn't get deleted. Would it be possible to populate the
remote's view of referenced objects into this, at the point of clone,
push or pull, which would seem to be the points at which this might be
changing.

Obviously this is of no use if you're 'anonymously' poncing off a
third repo to save clone time, but if you're in control of both repo's
it might be useful.

Mike
