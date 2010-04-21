From: Eric Raymond <esr@thyrsus.com>
Subject: Re: CIA hook for contrib/
Date: Wed, 21 Apr 2010 11:51:49 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100421155149.GA11223@thyrsus.com>
References: <20100327102632.GA5043@thyrsus.com>
 <20100421101002.GD3563@machine.or.cz>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Apr 21 17:52:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4cDW-0006v6-Jj
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 17:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786Ab0DUPvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 11:51:51 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:53709
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753Ab0DUPvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 11:51:50 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 29A7A475FF1; Wed, 21 Apr 2010 11:51:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100421101002.GD3563@machine.or.cz>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145439>

Petr Baudis <pasky@suse.cz>:
> On Sat, Mar 27, 2010 at 06:26:32AM -0400, Eric Raymond wrote:
> > Upon investigating further, I find that ciabot.sh seems to be a
> > derivative of ciabot.pl, which is a dangling bit of the moribund
> > Cogito project.  I have been unable to get responses from the authors
> > of either ciabot.sh or ciabot.pl.
> 
>   Strange, I received no mail from you. When did you send it?

About three weeks ago now.  Sorry, it appears I fat-fingered your
address.  I did eventually hear from the author of the 2008 sh
version; he passed me the maintainer's baton on that one.
 
>   I'm happy that someone resurrected the hook script, thanks for that!
> By the way, you seem to drop support for XML::RPC altogether while the
> original ciabot.pl could use both. While XML::RPC requires another
> dependency (not sure if plain Python installation can do it) and it can
> time out in case of CIA server trouble (not sure how common these are
> nowadays), the distinct advantage is that the commits will always end up
> in correct order, while it seemed to be common that by mail, push of
> multiple commits would reorder them randomly.

Ah, I did not know of that advantage, it wasn't documented anywhere.
It's a sufficient reason to bring back XML-RPC support...and I
have just done so in the Python version.

> > # update: You have to call it once per merged commit:
> > #
> > #       refname=$1
> > #       oldhead=$2
> > #       newhead=$3
> > #       for merged in $(git rev-list ${oldhead}..${newhead} | tac) ; do
> > #               /path/to/ciabot.bash ${refname} ${merged}
>                   ^^^^^^^^^^^^^^^^^^^^
> 
> Obsolete .bash reference.

Fixed, thanks.

> I personally find git-describe'd revspecs extremely ugly, unreadable and
> less practical than plain hex ids (maybe I'm weird?), it would be really
> nice to get a configuration choice between git describe and just:
> 
> 	rev=$(echo "$merged" | cut -c 1-12)
> 
> (Not sure about the bashism rant since you can trivially just replace it
> with the cut.)

Good point about use of cut; I'll do that.  

I've implemented a revformat variable, but defaulted it to 'describe'.
 
> I would personally prefer to have this configurable; I consider trying
> to protect your e-mail address against harvesters is a lost fight anyway
> and you'd be much better off just getting a good spam filter, rather
> than making yours and others' life harder by trying to fight in vain.
> But it's not too important for me since I can just disable this easily.

But email name collisions within projects are vanishingly rare, so I
don't see a lot of benefit in publishing the FQDN.
 
> Your life would be much easier in both the shell and python script if
> you used something like:
> 
> 	git log -1 '--pretty=format:%an <%ae>%n%at%n%s'
> 
> You would also get <ts> in the correct format, incl. timezone correction.

Good point.  I inherited that nasty code; perhaps this facility did not
exist when it was written.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
