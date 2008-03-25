From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH 7/7] cvsserver: Use the user part of the email in log and annotate results
Date: Tue, 25 Mar 2008 10:39:08 +0100
Message-ID: <b77c1dce0803250239o249a9059sbaafccf9ddea5e22@mail.gmail.com>
References: <cover.1206393086.git.dash@foobox.net>
	 <01e5947cde524f4eb97a86785d0e1f28e2d040e0.1206393086.git.dash@foobox.net>
	 <20080325092621.GN25732@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Damien Diederen" <dash@foobox.net>,
	"Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:40:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je5dM-00055B-Is
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 10:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbYCYJjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 05:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbYCYJjL
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 05:39:11 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:60495 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbYCYJjK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 05:39:10 -0400
Received: by py-out-1112.google.com with SMTP id u52so4818611pyb.10
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=x4tpcHfDQUJxf0uNlA+OHgiN+uh5xdHQpJynCV3fBYw=;
        b=Cvg3uynivQU9qcd8ihFi8R1kv9dGMCQ6wEeL6GMCHErd6lys4wVMhxrA/Pv7tILn4YQ3+9TitoPbygn0AQxJsKbeNhY5Tho3v9+V5nKw3lRMLMwLq7Xp3Abc3cL4z+hR0fnwp809XXaZy2Nm7bQlncV1LtT62B0xJFiHaG15fwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AjeLQhtXNZ4Yh1jCAMIBOvz/F90UXWaE5Fv5glvPRZ4iZTWF1yEPMF04ouVnCCOF1OWut+Lce/H4ab1IPZhq7iqbzPPuvFyfreWwpfYoq86DZ0gv6j3KD4WmBH24K5cdPyzFEZES5JyvRQLBGwiQfFgnwjnO5+BDDXblmv5Awko=
Received: by 10.141.171.6 with SMTP id y6mr3068317rvo.84.1206437948676;
        Tue, 25 Mar 2008 02:39:08 -0700 (PDT)
Received: by 10.142.156.10 with HTTP; Tue, 25 Mar 2008 02:39:08 -0700 (PDT)
In-Reply-To: <20080325092621.GN25732@mail-vs.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78164>

On 25/03/2008, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> On Mon, Mar 24, 2008 at 11:50:55PM +0100, Damien Diederen wrote:
>  > +# Generate a CVS author name from Git author information, by taking
>  > +# the first eight characters of the user part of the email address.
>  > +sub cvs_author
>  > +{
>  > +    my $author = shift;
>  > +
>  > +    $author =~ s/.*<([^>]+)\@[^>]+>$/$1/;
>  > +    $author =~ s/^(.{8}).*/$1/;
>
>
> IMHO substr($author, 0, 8) would be easier to read here. (It is also
>  much faster according to some quick benchmarks I just ran)

While we're at nitpicking:
Faster, shorter, and probably more robust if no @ appears in the email address:

my $author_line = shift;
(my $author) = $author_line =~ /<([^>@]{1,8})/;
