From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and GCC
Date: Wed, 5 Dec 2007 20:54:28 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712052033570.13796@woody.linux-foundation.org>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com>  <20071205.182815.249974508.davem@davemloft.net>  <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com>  <20071205.185203.262588544.davem@davemloft.net>   <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> <1196915112.10408.66.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Berlin <dberlin@dberlin.org>, David Miller <davem@davemloft.net>,         ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: gcc-return-142720-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 05:55:08 2007
Return-path: <gcc-return-142720-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J08lP-0001hq-UF
	for gcc@gmane.org; Thu, 06 Dec 2007 05:55:08 +0100
Received: (qmail 32249 invoked by alias); 6 Dec 2007 04:54:49 -0000
Received: (qmail 32237 invoked by uid 22791); 6 Dec 2007 04:54:48 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 04:54:39 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB64sTi6023383 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Wed, 5 Dec 2007 20:54:34 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB64sSP6009361; 	Wed, 5 Dec 2007 20:54:28 -0800
In-Reply-To: <1196915112.10408.66.camel@brick>
X-MIMEDefang-Filter: lf$Revision: 1.188 $
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67237>



On Wed, 5 Dec 2007, Harvey Harrison wrote:
> 
> If anyone recalls my report was something along the lines of
> git gc --aggressive explodes pack size.

Yes, --aggressive is generally a bad idea. I think we should remove it or 
at least fix it. It doesn't do what the name implies, because it actually 
throws away potentially good packing, and re-does it all from a clean 
slate.

That said, it's totally pointless for a person who isn't a git proponent 
to do an initial import, and in that sense I agree with Daniel: he 
shouldn't waste his time with tools that he doesn't know or care about, 
since there are people who *can* do a better job, and who know what they 
are doing, and understand and like the tool.

While you can do a half-assed job with just mindlessly running "git 
svnimport" (which is deprecated these days) or "git svn clone" (better), 
the fact is, to do a *good* import does likely mean spending some effort 
on it. Trying to make the user names / emails to be better with a mailmap, 
for example. 

[ By default, for example, "git svn clone/fetch" seems to create those 
  horrible fake email addresses that contain the ID of the SVN repo in 
  each commit - I'm not talking about the "git-svn-id", I'm talking about 
  the "user@hex-string-goes-here" thing for the author. Maybe people don't 
  really care, but isn't that ugly as hell? I'd think it's worth it doing 
  a really nice import, spending some effort on it.

  But maybe those things come from the older CVS->SVN import, I don't 
  really know. I've done a few SVN imports, but I've done them just for 
  stuff where I didn't want to touch SVN, but just wanted to track some 
  project like libgpod. For things like *that*, a totally mindless "git 
  svn" thing is fine ]

Of course, that does require there to be git people in the gcc crowd who 
are motivated enough to do the proper import and then make sure it's 
up-to-date and hosted somewhere. If those people don't exist, I'm not sure 
there's much idea to it.

The point being, you cannot ask a non-git person to do a major git import 
for an actual switch-over. Yes, it *can* be as simple as just doing a

	git svn clone --stdlayout svn://svn://gcc.gnu.org/svn/gcc gcc

but the fact remains, you want to spend more effort and expertise on it if 
you actually want the result to be used as a basis for future work (as 
opposed to just tracking somebody elses SVN tree).

That includes:

 - do the historic import with good packing (and no, "--aggressive" 
   is not it, never mind the misleading name and man-page)

 - probably mailmap entries, certainly spending some time validating the 
   results.

 - hosting it

and perhaps most importantly

 - helping people who are *not* git users get up to speed.

because doing a good job at it is like asking a CVS newbie to set up a 
branch in CVS. I'm sure you can do it from man-pages, but I'm also sure 
you sure as hell won't like the end result.

		Linus
