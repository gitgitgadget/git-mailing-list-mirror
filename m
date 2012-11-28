From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 04:44:54 +0100
Message-ID: <CAMP44s1Kv4r+mq5Hr8-4gN6pZ+FO+zazu+YHO2O53X8iuT0GFQ@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com>
	<CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
	<7vzk22lmz9.fsf@alter.siamese.dyndns.org>
	<20121127230419.GA26080@thyrsus.com>
	<CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
	<20121128001231.GA27971@thyrsus.com>
	<CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
	<CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
	<20121128011750.GA23498@sigill.intra.peff.net>
	<20121128032337.GB1669@thyrsus.com>
	<20121128033009.GA3931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:45:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYaI-0007Ni-R0
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab2K1Do4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:44:56 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62543 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab2K1Doz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:44:55 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13145456oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 19:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jPn8dZDgjGKsJ4uBFgnRaMf77hqvdab2cU/byiAbXnA=;
        b=BuovOvpff0pIciB8TXkX/lr4Xkkz2A6U6u+O+g3arPW6LhrdOdjUIEPHO87/vzFbBK
         Ti/U/7/xrjksr1R6eU0jZ0wHbOlouSGwGlisZ+i0gtoep+dNsnd8DoBSRf4xgClaTtLt
         YIqW/feJ0u0BvY81QnIJeHO5Mp8DDLTIkeWQJhJMWLJ7qRtvQ4fBK1LbxwL0gmbXRooJ
         7LU5aYi2sGptvnYdIOK9pHxdoW5s+PTsHm8jEnFPRULfGMF0IhNaa65AKGzFkw2XyrPP
         s52Isuua59f90ReKaovhsiPFK+OaONmCOoUhrQCX3OG1Lp2WN8Pb7fHIENgYDzidZ4+u
         DZiw==
Received: by 10.182.21.175 with SMTP id w15mr1729679obe.28.1354074294239; Tue,
 27 Nov 2012 19:44:54 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 19:44:54 -0800 (PST)
In-Reply-To: <20121128033009.GA3931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210693>

On Wed, Nov 28, 2012 at 4:30 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 27, 2012 at 10:23:37PM -0500, Eric S. Raymond wrote:
>
>> Jeff King <peff@peff.net>:
>> > But I really wonder if anybody actually cares about adding sub-second
>> > timestamp support, or if it is merely "because SVN has it".
>>
>> There's actually one possible other reason to care.  1-second granularity
>> isn't quite fine enough to guarantee that a (committer, timestamp)
>> pair is a unique key.  1 microsecond granularity would be.
>
> You can't guarantee that such a pair is unique, anyway, due to clock
> skew.
>
> A much more compelling argument to me would be that you are doing some
> bidirectional magic between git and svn, and you want to make make sure
> that an svn->git->svn translation will result in the exact same bytes.
> Then the argument is still "because SVN has it", but at least it is "and
> we interoperate with it" and not simply chasing a cool but useless
> feature.

But the same can be said of mercurial and bzr. This can be solved
attaching some external SCM information in notes, and somehow make
fast-export throw that info along with the commit.

For now the solution has been to append the extra information into the
commit message, which is ugly and hacky, but it works.

-- 
Felipe Contreras
