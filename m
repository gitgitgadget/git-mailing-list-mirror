From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: help moving boost.org to git
Date: Tue, 6 Jul 2010 14:13:47 -0400
Message-ID: <AANLkTikfTFw_UdV1ia58MbWxH4h8TJAr-Y5WPvlXCjeJ@mail.gmail.com>
References: <4C31E944.30801@boostpro.com> <20100705220443.GA23727@pvv.org> 
	<4C32668E.9040000@boostpro.com> <AANLkTimAqL8gvgIisLpWE6xj2p0jEZD5wetdGYJnOpdr@mail.gmail.com> 
	<4C3275C0.8000406@boostpro.com> <AANLkTikkKhvzsczKJwjsc0kmCmWQGAIUzc__Wr20Dbwd@mail.gmail.com> 
	<4C336F3D.1010906@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Niebler <eric@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 20:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWCew-00060D-Kv
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287Ab0GFSOK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 14:14:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34573 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab0GFSOI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 14:14:08 -0400
Received: by pvc7 with SMTP id 7so2743216pvc.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QtvbVMWmMiIVvZdZI3pDujTmb9sOl88P97Ex38WkbWw=;
        b=osHhWPNYG7KXRUh1yEOFQIRb1yOuWu91O54nXoLTaAer2adwGuQrKQyyV6xxeyVR2D
         7QN081dCMfADkVqTjnHxSzTVb+lFoyR9Q3COrzdxYy4PPy18dWUoAuQDolq1XMksTezw
         XOlcq6E2rQIA3pZrJUxuLhDq+UO0wS+Tqb88Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FdbjUfrRP/lFqxkYKnh8VXeOul4wZi0C0nE5tH9jFC7xd8oKaA9Db29Ahnu/bpe4Ej
         bUJeLtSP3zvetd9K2rdZ8v/ynWjyxShepaVfctfQq+dyYXSawoiTSQfX0Q62FxVzar0z
         BE6PmElffUgKhaMiwBfX3VOn8/LdFHj7Jf8go=
Received: by 10.142.164.3 with SMTP id m3mr5967600wfe.293.1278440047649; Tue, 
	06 Jul 2010 11:14:07 -0700 (PDT)
Received: by 10.151.45.4 with HTTP; Tue, 6 Jul 2010 11:13:47 -0700 (PDT)
In-Reply-To: <4C336F3D.1010906@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150383>

On Tue, Jul 6, 2010 at 2:00 PM, Eric Niebler <eric@boostpro.com> wrote:
> On 7/6/2010 1:27 PM, Avery Pennarun wrote:
>> The primary advantage of grafts is that you can do something easy
>> *right now* and then fix it all up later. =A0eg. if you screw up you=
r
>> history extraction and do it better later, you can just re-graft it
>> and you're done.
>
> How does one screw up the history extraction, if one is not doing any
> fancy history rewriting (in this scenario)? Be there dragons?

Well, "rewriting history" necessarily involves changing things about
the permanent record.  Every time you change things, you have a
potential to change them incorrectly.  So in general, not rewriting is
less error-prone than rewriting :)

Specifically, with a tool like git-subtree, it only really works if a
particular subproject has always existed in the same subdir of your
repo since it started.  If the subdir was ever renamed, or if some of
the files were previously part of one subdir but then moved around,
git-subtree doesn't (currently) know how to deal with that.
git-filter-branch can do anything you want, but you have to teach it
how, which is obviously even *more* error prone.

Things are also a little messy if you have some kind of top-level
directory with build infrastructure shared by all the subdirs.  Does
the top-level Makefile have a list of the subdirs it needs to build?
If so, there's no way to extract only a subset of true history that
will still build correctly - it'll be looking for directories that you
explicitly removed.  You could update the Makefiles programmatically
in every single revision, but that's starting to get extremely
messy... and your history stops representing what *real life* really
looked like at the time.

If your subdirs haven't been moving around (which sounds like that
might be the case for you), and you don't have any top-level files
that you care about, rewriting might turn out to be straightforward.
You could also make the decision on a subdir-by-subdir basis, I guess.

Have fun,

Avery
