From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Fri, 25 Jul 2008 06:21:17 +0700
Message-ID: <fcaeb9bf0807241621y60b0341ej8f9f3b591ef12baf@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <m3tzefvd3q.fsf@localhost.localdomain>
	 <fcaeb9bf0807240358l6584c063u85179196bd6db30a@mail.gmail.com>
	 <200807242201.23991.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 01:22:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMA8b-00084b-Kg
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 01:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYGXXVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 19:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbYGXXVT
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 19:21:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:2095 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbYGXXVS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 19:21:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1529466fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BldjEed43Bz923KOfZv0MgPSbZmySpUy7NDYhkcV0Dw=;
        b=O50dQddenyfTmvhacAwo+s3w8RH8T72xMNZJt+8ih7QfmX6//2Nvxc4/qHqnY26CYz
         qiBoQ5sYB+9YLMZtm/iFu+QdoWxd8Dh5r9QaI+ksXIiIMEkC+W6Q5bLrJKoQDXRR4bLk
         w+mVlODqHBszzB1Tnv/IQ32fsPVKZB7/2FFGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sMAamdY3YnoCah1eb1c91C5Se513Dh3T7V5Z06i1XSAsaBY7VWMVtuY9xr85ZxNrEH
         5uihPzUIZba23qg9iJ+HJRLgSfgBQRAJwzRdOddo/L6VRkZL2EpymJ7WtDr03vL9XjTR
         w3qyWr4RZefwjdXjMEKlKirGeZFAHJVUlFcBk=
Received: by 10.86.1.11 with SMTP id 11mr1365585fga.27.1216941677312;
        Thu, 24 Jul 2008 16:21:17 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 16:21:17 -0700 (PDT)
In-Reply-To: <200807242201.23991.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89970>

On 7/25/08, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:
>
> > On 7/24/08, Jakub Narebski <jnareb@gmail.com> wrote:
>  > >
>  > >  Second, I think you can simply special case .git* files (.gitignore,
>  > >  .gitattributes, .gitmodules), and always check them out for all
>  > >  intermediate directories (unless configured otherwise, of course).
>  > >  So for example if you have the following directory structure:
>  > >
>  > >   A/.gitignore
>  > >   A/a
>  > >   A/B1/.gitignore
>  > >   A/B1/b
>  > >   A/B2/.gitignore
>  > >   A/B2/c
>  > >
>  > >  and you are checking out only subdirectory 'B1' (and all files in it;
>  > >  if subdirectories are checked out recursively it depends on
>  > >  configuration), and if for example there is .gitignore in every
>  > >  directory, then checked out tree would look like this:
>  > >
>  > >   A/.gitignore
>  > >   A/B1/.gitignore
>  > >   A/B1/b
>  > >
>  > >  The ability to do this is one of advantages of 'sparse' checkout over
>  > >  'subtree' checkout.
>  >
>  > Or teach git to use index version of those files. Or collect all those
>  > files, combine them and put the result to .git/info/exclude (and
>  > similar places). Anyway well organized repos won't have this problem.
>  >
>  > Checking some files out as read-only (like this case) may be
>  > interesting. Though I do not how much complicated it can be.
>
>
> I think teaching git to use index version of .git* files (.gitignore,
>  .gitattributes, .gitmodules) would be much more work than adding
>  default rule that .git* files in leading directories are by default
>  checked out, just like leading directories are checked out.  This
>  would limit modifying git code, I think, and chances for errors.
>
>  Having "leading" directories and files read-only would be a good idea,
>  I think.
>
>  I don't understand the sentence "well organized repos won't have this
>  problem". I think well organized repos _would_ have this problem,
>  because of maintained and distributed top-level .gitignore and
>  .gitattributes.

I wrote that with svn repos in mind. If those repos are to be
partially checked out, .svnignore would be in subdirectories rather
than at toplevel. Anyway that may not be true.

>  P.S. I hope that 'sparse checkout' feature would be ready for 1.7.0
>
> --
>  Jakub Narebski
>  Poland
>


-- 
Duy
