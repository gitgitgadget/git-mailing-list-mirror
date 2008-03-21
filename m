From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: [PATCH v3] pretty.c: add %x00 format specifier.
Date: Fri, 21 Mar 2008 12:45:36 -0500
Message-ID: <5d46db230803211045w3bc2f407n76f188b1d77680d7@mail.gmail.com>
References: <5d46db230803210805j95c6029m19b284836dcb504a@mail.gmail.com>
	 <alpine.LSU.1.00.0803211646010.4124@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:47:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JclJr-0001Op-0D
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 18:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbYCURpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 13:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756551AbYCURpi
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 13:45:38 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:18307 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbYCURph (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 13:45:37 -0400
Received: by rn-out-0910.google.com with SMTP id v46so1149158rnb.15
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 10:45:37 -0700 (PDT)
Received: by 10.150.177.20 with SMTP id z20mr1716368ybe.137.1206121536926;
        Fri, 21 Mar 2008 10:45:36 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Fri, 21 Mar 2008 10:45:36 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803211646010.4124@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77750>

On Fri, Mar 21, 2008 at 10:47 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Fri, 21 Mar 2008, Govind Salinas wrote:
>
>  > This adds a %x00 format which parses the 00 as hex encoding for a byte
>  > and prints the resulting byte.  This can be used to add null bytes or
>  > other bytes that can make machine parsing easier.  It is also necessary
>  > to use fwrite to print out the data since printf will terminate if you
>  > feed it a null.
>  >
>  > Junio supplied the hex decoding.
>
>  This is all nice and well, but if I understood you correctly, your
>  original aim was to have a pretty-formatted list of the revisions, but
>  NUL-delimited for easy parsing.
>
>  Which you can do with "git log --pretty=format:%s -z" right now.
>
>  Ciao,
>  Dscho
>
>

Unfortunately that almost work for me.  I am in the following situation
If I stick to just using the --pretty=format options then I would be fine
but I am also adding --stat and -p to git-log, so now I have 3 multiline
hunks of data and I need to tell where each one ends deterministically.
I *could* just look for "---" and "diff  --git" at every line but I would prefer
to use a delimiter.

Alternatively, if -z would add a null before the diffstat was printed, that
would probably work for me as well.  Even so, using the same delimiter
is nicer than parsing part with newlines and part with nulls, which I would
have to do if I just used -z.  Think
"%H%x00%ae%x00%an%x00%s%x00%b%x00 -z -p --stat". there
everything splits nicely with nulls.  The alternative (with -z adding a null
before the diffstat is "%H%n%ae%n%an%n%s%n%b -z -p --stat" which
would work, but I would have to parse the last 3 fields differently.

Perhaps there is a better way to get all this information.  But I do want
all the information to come from the same call.

Thanks,
Govind.
