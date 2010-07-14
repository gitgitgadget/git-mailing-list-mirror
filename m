From: Stefan Sperling <stsp@elego.de>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 14 Jul 2010 19:24:29 +0200
Message-ID: <20100714172429.GC25861@ted.stsp.name>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
 <20100714153206.GH25630@jack.stsp.name>
 <20100714160149.GA7561@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "dev@subversion.apache.org" <dev@subversion.apache.org>,
        Bert Huijben <rhuijben@collab.net>,
        Daniel Shahaf <d.s@daniel.shahaf.name>,
        Will Palmer <wmpalmer@gmail.com>,
        David Michael Barr <david.barr@cordelta.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sverre Rabbelier <srabbelier@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: dev-return-5009-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 14 19:25:21 2010
Return-path: <dev-return-5009-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-5009-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OZ5ht-0007Ya-UB
	for gcvsd-dev@lo.gmane.org; Wed, 14 Jul 2010 19:25:18 +0200
Received: (qmail 28080 invoked by uid 500); 14 Jul 2010 17:25:16 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 28072 invoked by uid 99); 14 Jul 2010 17:25:15 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 14 Jul 2010 17:25:15 +0000
X-ASF-Spam-Status: No, hits=-0.7 required=10.0
	tests=RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: local policy)
Received: from [192.109.42.8] (HELO einhorn.in-berlin.de) (192.109.42.8)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 14 Jul 2010 17:25:06 +0000
X-Envelope-From: stsp@stsp.name
Received: from ted.stsp.name (ted.stsp.name [217.197.84.186])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o6EHOWRt025160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Jul 2010 19:24:33 +0200
Received: from ted.stsp.name (stsp@localhost [127.0.0.1])
	by ted.stsp.name (8.14.3/8.14.3) with ESMTP id o6EHOWpM027373;
	Wed, 14 Jul 2010 19:24:32 +0200 (CEST)
Received: (from stsp@localhost)
	by ted.stsp.name (8.14.3/8.14.3/Submit) id o6EHOTS4022138;
	Wed, 14 Jul 2010 19:24:29 +0200 (CEST)
Mail-Followup-To: Ramkumar Ramachandra <artagnon@gmail.com>,
	"dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100714160149.GA7561@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151018>

On Wed, Jul 14, 2010 at 06:01:49PM +0200, Ramkumar Ramachandra wrote:
> Yeah, I forgot to ask about this: passing 0 as an argument to the
> replay API doesn't seem to work. Why? How do I dump revision 0 then?

Indeed. This seems to be a problem in the replay API.
This is not a problem for svnsync itself because svnsync manually
sets the revision properties while doing a sync.
We can fix the replay API to allow svnrdump to get revprops for r0.
 
> >  - You're missing a couple of fields:
> >    The UUID of the repository.
> >    Text-content-sha1
> >    Text-delta-base-md5
> >    Text-delta-base-sha1
> 
> Yes, I'm aware.

OK.
 
> >  - I've seen a "Prop-delta: true" line which svnadmin dump does not print.
> 
> Correct. `svnadmin dump` has a logic for determining when the prop is
> really a delta (as opposed to a delta against /dev/null). Since
> there's no harm printing extra Prop-delta headers, I decided not to
> implement this logic.

We can fix this later.

> >  - You're missing some newlines that svnadmin dump prints (cosmetic,
> >    but it would be nice if both produced matching output).
> 
> This isn't in the dump-load-format spec document (atleast afaik), and
> it's very hard to get this right (yes, I tried). Moreover, it's very
> ungratifying to have a few extra newlines (reverse engineered from
> `svnadmin dump`) printed at the end of 10+ hrs of work; yes, that's
> what I estimate it'll take to fix this.

Well, it would be really nice to have.
Details like this are time sinks, I know. But it pays off.
You don't have to do it right away. We can file an issue so we don't
forget about fixing it before 1.7 release.
If necessary, feel free to adjust the output of svnadmin dump a little
if that makes it easier for svnrdump to produce matching output.

> gawk '$0 !~ "Prop-delta: true|Text-delta-base-|sha1|Text-copy-source-|^-$" && $0 ~ "^+|^-" { print; }'

Fine for testing. But I still think the end-result should look just
like svnadmin dump, if possible. That would make testing even easier.

> > Please get rid of all global variables in svnrdump.c:
> Will do. I'm waiting for commit access, because I don't want to make
> un-versioned edits to the file that I cannot track or revert in
> future.

What about using git until then? It does not matter which state you
initially import into the Subversion repository. But well, whatever
works for you is best.
 
> Please see the current `validate.sh` for an example of the
> functionality I'll write into the unit tests.

Thanks, I'll take a look.

Stefan
