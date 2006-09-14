From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 07:36:56 +0200
Message-ID: <4508EA78.5030001@alum.mit.edu>
References: <45084400.1090906@bluegap.ch>	<9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>	<46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>	<450872AE.5050409@bluegap.ch> <9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Markus Schiltknecht <markus@bluegap.ch>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, monotone-devel@nongnu.org,
        dev@cvs2svn.tigris.org
X-From: dev-return-1647-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 07:37:24 2006
Return-path: <dev-return-1647-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNjud-0007T4-4e
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 07:37:24 +0200
Received: (qmail 6781 invoked by uid 5000); 14 Sep 2006 05:37:21 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 6769 invoked from network); 14 Sep 2006 05:37:21 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAN2GCEWLbAIJDg
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="33911717:sNHT18049094"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060728 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26986>

Jon Smirl wrote:
> On 9/13/06, Markus Schiltknecht <markus@bluegap.ch> wrote:
>> Martin Langhoff wrote:
>> > On 9/14/06, Jon Smirl <jonsmirl@gmail.com> wrote:
>> >> Let's copy the git list too and maybe we can come up with one importer
>> >> for everyone.

That would be great.

> AFAIK none of the CVS converters are using the dependency algorithm.
> So the proposal on the table is to develop a new converter that uses
> the dependency data from CVS to form the change sets and then outputs
> this data in a form that all of the backends can consume. Of course
> each of the backends is going to have to write some code in order to
> consume this new import format.

Frankly, I think people are getting the priorities wrong by focusing on
the format of the output of cvs2svn.  Hacking a new output format onto
cvs2svn is a trivial matter of a couple hours of programming.

The real strength of cvs2svn (and I can say this without bragging
because most of this was done before I got involved in the project) is
that it handles dozens of peculiar corner cases and bizarre CVS
perversions, including a good test suite containing lots of twisted
little example repositories.  This is 90% of the intellectual content of
cvs2svn.

I've spent many, many hours refactoring and reengineering cvs2svn to
make it easy to modify and add new features.  The main thing that I want
to change is to use the dependency graph (rather than timestamps tweaked
to reflect dependency ordering) to deduce changesets.  But I would never
think of throwing away the "old" cvs2svn and starting anew, because then
I would have to add all the little corner cases again from scratch.

It would be nice to have a universal dumpfile format, but IMO not
critical.  The only difference between our SCMs that might be difficult
to paper over in a universal dumpfile is that SVN wants its changesets
in chronological order, whereas I gather that others would prefer the
data in dependency order branch by branch.

I say let cvs2svn (or if you like, we can rename it to "cvs2noncvs" :-)
) reconstruct the repository's change sets, then let us build several
backends that output the data in the format that is most convenient for
each project.

Michael
