From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Tue, 13 May 2008 21:30:45 +0200
Message-ID: <8c5c35580805131230p37953e33he97803c0609012fa@mail.gmail.com>
References: <200805011220.58871.jnareb@gmail.com>
	 <200805130855.08133.jnareb@gmail.com>
	 <8c5c35580805130939m1a1ef8e0yd72402f3c79190ea@mail.gmail.com>
	 <200805131904.38317.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"John Hawley" <warthog19@eaglescrag.net>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 21:32:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw0E6-0007mH-Ms
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 21:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758657AbYEMTay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 15:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758186AbYEMTay
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 15:30:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:23501 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758259AbYEMTax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 15:30:53 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1668482ywe.1
        for <git@vger.kernel.org>; Tue, 13 May 2008 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=omaEBKArIBOnSTHmnXrL1dO9b1QovPl5cKZjVGpokrA=;
        b=rQMnBZsLFsoOT3L17gEfjZM1W9l6fakGtENkMXOu0YwRphflVOn4BrFD2VJ7Myp25JLZ1wSmRg5Y4DKdP3+32tDqJvT5lhgL3ppmgvk1ibDFcLx0xA9NZXhpkGljPEdiUqViIRTVU453dt29cJgD1Z0tuJsZv960R62fdXm9OBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z4pLOKtW8ymWUN1mX0EO4kwp/nXYkNZmDpvxY0pLtdRN1Ac5la5S3pKTSh31jaWSoP/HGi3J19nZZ20H6tzeX6mEXprNf38EuSvyku5IINy57HAWZwiQmnJ0iL1FGhIC2CqKDBU/mkgOpmBqV1zo6OhnZZtTpkMBc+BEkWSXyMc=
Received: by 10.150.83.41 with SMTP id g41mr203643ybb.194.1210707045124;
        Tue, 13 May 2008 12:30:45 -0700 (PDT)
Received: by 10.151.39.3 with HTTP; Tue, 13 May 2008 12:30:45 -0700 (PDT)
In-Reply-To: <200805131904.38317.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82038>

On Tue, May 13, 2008 at 7:04 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 13 May 2008, Lars Hjemli wrote:
>  > On Tue, May 13, 2008 at 8:55 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>  >>
> >> But please take into account that gitweb performance, and I guess any
>  >> git web interface performance, is I/O bound and not CPU bound (at least
>  >> according to what I remember from J.H. emails).  So a little more
>  >> processing is I think less important than avoiding hitting the repos.
>  >
>  > Yeah, that's a pretty convincing argument for "cache the data, not the
>  > output", at least for gitweb (cgit never touches the repos to generate
>  > the project list/search).
>
>  First, this is less argument for "cache data" against "cache output",
>  only against disregarding "cache data" for assumed performance reasons,
>  while it "cache data" can be useful in some places.

Ok, then I misinterpreted your argument.


>  Second, gitweb's projects list page contains "Last Changed" column,
>  and you _*have*_ to hit repositories for this data

No you don't. One alternative is to use the post-update hook in each
repo to update a separate file with info about last-changed-time.
Another (less accurate) alternative is to stat one or more of
packed-refs and refs/heads/*; cgit uses both of these alternatives to
avoid hitting the repo (i.e. object-db) when the project list/search
page is generated.

--
larsh
