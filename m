From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 18:59:17 -0400
Message-ID: <20061020225917.GA30584@coredump.intra.peff.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	<200610201821.34712.jnareb@gmail.com>
	<20061020181210.GA29843@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 00:59:33 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3Kr-00048j-PN
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 00:59:29 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gb3Kp-0003Q1-Dz; Fri, 20 Oct 2006 23:59:27 +0100
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]
	helo=peff.net) by esperanza.ubuntu.com with smtp (Exim 4.60)
	(envelope-from <peff@peff.net>) id 1Gb3Km-0003Pp-10
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 23:59:24 +0100
Received: (qmail 28123 invoked from network); 20 Oct 2006 18:59:18 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
	by 66-23-211-5.clients.speedfactory.net with SMTP;
	20 Oct 2006 18:59:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation);
	Fri, 20 Oct 2006 18:59:17 -0400
To: Jan Hudec <bulb@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29551>

On Fri, Oct 20, 2006 at 08:12:10PM +0200, Jan Hudec wrote:

> At this point, I expect the tree to look like this:
> A$ ls -R
> .:
> data/
> data:
> hello.txt
> A$ cat data/hello.txt
> Hello World!

Git does what you expect here.

> A$ VCT mv data greetings
> A$ VCT commit -m "Renamed the data directory to greetings"
> B$ echo "Goodbye World!" > data/goodbye.txt
> B$ VCT add data/goodbye.txt
> B$ VCT commit -m "Added goodbye message."
> A$ VCT merge B
> 
> And now I expect to have tree looking like this:
> 
> A$ ls -R
> .:
> greetings/
> greetings:
> hello.txt
> goodbye.txt

Git does not do what you expect here. It notes that files moved, but it
does not have a concept of directories moving.  Git could, even without
file-ids or special patch types, figure out what happened by noting that
every file in data/ was renamed to its analogue in greetings/, and infer
that previously non-existant files in data/ should also be moved to
greetings/.

However, I'm not sure that I personally would prefer that behavior. In
some cases you might actually WANT data/goodbye.txt, and in some other
cases a conflict might be more appropriate. In any case, I would rather
the SCM do the simple and predictable thing (which I consider to be
creating data/goodbye.txt) rather than be clever and wrong (even if it's
only wrong a small percentage of the time).

In short, git doesn't do what you expect, but I'm not convinced that
it's a bug or lack of feature, and not simply a difference in desired
behavior.

-Peff
