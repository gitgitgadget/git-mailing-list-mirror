From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 13:20:09 -0400
Message-ID: <20100831172008.GE16034@foucault.redhat.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
 <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
 <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
 <20100831143839.GC16034@foucault.redhat.com>
 <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com>
 <20100831155159.GD16034@foucault.redhat.com>
 <AANLkTikrQhzyPckN2t3+FzaJFzYboDRVfW3bPPZOGpJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 19:20:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqUVR-0007GK-Fb
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 19:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab0HaRUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 13:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437Ab0HaRUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 13:20:13 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7VHKBTu007065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 31 Aug 2010 13:20:12 -0400
Received: from foucault.redhat.com (vpn-11-196.rdu.redhat.com [10.11.11.196])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7VHK9JN017944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 31 Aug 2010 13:20:11 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikrQhzyPckN2t3+FzaJFzYboDRVfW3bPPZOGpJQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154944>

On Tue, Aug 31, 2010 at 05:47:42PM +0100, Luke Kenneth Casson Leighton wrote:
> On Tue, Aug 31, 2010 at 4:52 PM, Casey Dahlin <cdahlin@redhat.com> wrote:
> > Bittorrent has the luxury of being able to proxy for the poor firewall-bound
> > users since as long as there's one peer exposed to the internet you can have
> > any two other peers connect to him and give him the data they want to exchange,
> > to the benefit of all 3. Git won't work that way because not everyone in the
> > swarm wants all chunks of data, so if you found a proxy node, you might have to
> > make him carry data (possibly lots of data) that he has no personal interest
> > in.
> 
>  ah, no you don't.
> 
>  but - think about it: even if they don't, if they don't want the set
> of commits that get you up to a particular HEAD or other tag or
> branch, what the hell are they doing?? :)  from what i can gather, git
> simply doesn't operate in a way where you can "pick and choose" which
> commits you are and are not going to keep around, in order to
> reconstruct the repository.
> 
>  i hope that's right, because i'm counting on it.  i.e i'm counting on
> the following being true:
> 
>  "all copies of all git repositories have exactly the same objects
> such that git pack-object on the exact same ref and the exact same
> object ref will return exactly the same information".
> 
>  if anyone knows a reason why that is NOT the case, please could you tell me!
> 

Commits are always the same for everyone (though two commits you might think of
as "the same commit" may not be in git terms). Branches are pretty much always
subsets or supersets of oneanother. Repositories? Essentially snowflakes.

Try the kernel: Linus has a branch. Most individuals' repos are going to have
some subset of that branch checked out under various names. Not everyone will
have all of the commits though, nor will they necessarily want them just now.
Most people will have no ref pointing to the top commit of the Linus branch; it
will be a couple of commits down due to new things they've added on top. Refs
are NOT resource identifiers, and certainly not global resource identifiers.

Now consider the networking people. They have their own branch. It attaches to
the linus branch somewhere below the tip linus has published (probably at a
revision tag) and includes several unique commits. All the networking people
want those commits. None of the rest of people do. There's a btrfs branch too.
Some people want that, some don't. Some will have the networking and btrfs
branches. Most will have added commits on top privately.

Now consider share by email, where the same commit may appear in several
slightly different forms with different SHA 1s.

In summary, no. Repositories are balls of independently produced content. A
good peer to peer network needs to let any one client individually address
everything out there, but still take advantage of those instances where lots of
people do have copies of the same object.

--CJD
