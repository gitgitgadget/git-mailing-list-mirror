From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: .gitattributes on branch behaves unexpected. Should it be more stateless?
Date: Sat, 17 Jan 2015 13:16:21 -0000
Organization: OPDS
Message-ID: <B551DC4135DC4DA3B8BA5E1BBA36BBEC@PhilipOakley>
References: <CAGJ-DzH0meYgpE8My+UW4wbTxs6vo=wrgo0o21Lzh5Hg38ibEQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Max W" <max.w.7777777@googlemail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 17 14:16:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCTEI-0006JY-QV
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 14:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbbAQNPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 08:15:50 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:56245 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752477AbbAQNPu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jan 2015 08:15:50 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmkYAKlfulROl3fXPGdsb2JhbABagwZSWIMFgyptvw+FcwSBE0QBAQEBAQEFAQEBATggG4QHBgEEAQgBARkVHgEBJgYCAwUCAQMaAgUhAgIUAQQaBgcDFAYBGgIBAgMBCgOIBgy8CYZTjVmBIZFHLoETBY5MUYJ2hleNPoM9gWcMAYIcPjGCQwEBAQ
X-IPAS-Result: AmkYAKlfulROl3fXPGdsb2JhbABagwZSWIMFgyptvw+FcwSBE0QBAQEBAQEFAQEBATggG4QHBgEEAQgBARkVHgEBJgYCAwUCAQMaAgUhAgIUAQQaBgcDFAYBGgIBAgMBCgOIBgy8CYZTjVmBIZFHLoETBY5MUYJ2hleNPoM9gWcMAYIcPjGCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.09,417,1418083200"; 
   d="scan'208";a="770916977"
Received: from host-78-151-119-215.as13285.net (HELO PhilipOakley) ([78.151.119.215])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 17 Jan 2015 13:15:48 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262586>

> Hi,
>
> I am asking myself if git and .gitattributes should be more stateless? 
> i.e.
> whatever you have done before is irrelevant, when you reach status XYZ 
> with your
> git repo, it is EXACTLY and BINARY the same all the time and 
> everywhere.
>
> It took some time for me to figure out, that depending on HOW you 
> clone, the
> resulting local repo may differ. I did not expect this. I assumed that 
> when I
> clone, it is a clone (meaning: 100% identical). And that the things I 
> have done
> in my local repo before, don't have any relevance at all.
>

You don't say which parts you believe should be identical, nor why.

Internally Git can represent its object store in many ways based on some 
objects being 'loose' and some objects being 'packed'. However both 
styles of representation are of the same base objects and their 
contents.

Then we have external OS representation, in particular the end of line 
representations between the three main OS types Win/Mac/'nix. Git gives 
_you_ the ability the use any of these representations for the same base 
objects. Thus the object file with text "Hello World/EOL/Goodbye World" 
will have three different binary representations once you export them to 
the selected file system type (according to you .gitattributes 
settings).

If you always select LF endings for text files (both on the way in and 
on the way out of the repo), then you will get identical files on the 
different clones. Git has many settings for personalisation.

Does that help?

>
>
> ** How to reproduce **
> 1) create a repo, add a file with LF ending, add a .gitattributes 
> telling git to
>   do a CRLF conversion
> 2) clone the repo
> 3) on brach development, change .gitattributes to LF
> 4) clone again
> 5) clone again, directly onto the branch development (git clone -b)
>
>
> ** Expected result, (I) **
> clone 2) and original repo 1) are bytewise identical
>
> ** Actual result (I) **
> clone 2) and original repo 1) differ, 1) has LF, 2) has CRLF
> as I have been warned before, I am (more or less) fine/OK with this
>
>
> ** Expected result, (II) **
> - clone without -b (4) and clone with -b (5) are bytewise identical
> - I would have expected, that whatever I do, as soon as I have a clone 
> and I am
>  on branch "development", my file should be LF
> - I would have expected, that HOW you clone is irrelevant
>
> ** Actual result (II) **
> without -b (4) I have a CRLF file on my disk. with -b (5) I have a LF 
> file on my
> disk. The clones are not bytewise indentical. It appears as if the
> .gitattributes in branch development does not have any reliable 
> effect.
>
>
>
> A potential solution might be be that
> - checkout
> - commit (a modified .gitattribues)
> - <further git commands>
>  do change the files in the local repo.
> As of now my understanding is that this is not how .gitattributes (or
> .gitignore) are designed. .gitattributes only has influence on 
> pushing/fetching.
>
> I don't know if and which side effects would occur if this design 
> would be
> changed. Hence I am glad to hear any feedback on the issue described 
> above. And
> yes, I agree that this is a minor issue and that all .gitattribute 
> things are
> kind of edge cases.
>
> Thanks and with best regards,
> Max
>
>
>
>
>
>
> 1)
> mkdir git-bug-or-feature
> cd git-bug-or-feature
> git init
> echo "foo.bar eol=crlf" > .gitattributes
> echo "hello world" > foo.bar
> git add .
> git commit -m "now crlf"
> # [master (root-commit) 7f3f6b0] now crlf
> # warning: LF will be replaced by CRLF in foo.bar.
> # The file will have its original line endings in your working 
> directory.
> file foo.bar
> # foo.bar: ASCII text
> cd ..
>
> 2)
> git clone git-bug-or-feature git-bug-or-feature_clone
> cd git-bug-or-feature_clone
> file foo.bar
> # foo.bar: ASCII text, with CRLF line terminators
> cd ..
> rm -rf git-bug-or-feature_clone
>
> 3)
> cd git-bug-or-feature
> git branch development
> git checkout development
> echo "foo.bar eol=lf" > .gitattributes
> git add .
> git commit -m "now lf on branch development"
> file foo.bar
> # foo.bar: ASCII text
> git checkout master
> file foo.bar
> # foo.bar: ASCII text
> cd ..
>
> 4)
> git clone git-bug-or-feature git-bug-or-feature_clone
> cd git-bug-or-feature_clone
> file foo.bar
> --
philip 
