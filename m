From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v2 4/4] implement automatic fast forward merge for
	submodules
Date: Wed, 7 Jul 2010 15:35:58 +0200
Message-ID: <20100707133557.GA35678@book.hvoigt.net>
References: <cover.1278444110.git.hvoigt@hvoigt.net> <f17d78656a71558fd290e0b84cad03f22f6fcbd8.1278444110.git.hvoigt@hvoigt.net> <201007070152.17802.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, jens.lehmann@web.de
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 07 15:36:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWUnL-0005qw-Fs
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 15:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab0GGNgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 09:36:01 -0400
Received: from darksea.de ([83.133.111.250]:52750 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754803Ab0GGNgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 09:36:00 -0400
Received: (qmail 17262 invoked from network); 7 Jul 2010 15:35:58 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Jul 2010 15:35:58 +0200
Content-Disposition: inline
In-Reply-To: <201007070152.17802.johan@herland.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150469>

Hi,

On Wed, Jul 07, 2010 at 01:52:16AM +0200, Johan Herland wrote:
> On Tuesday 06 July 2010, Heiko Voigt wrote:
> [...]
> 
> > +	/* get all revisions that merge commit a */
> > +	snprintf(merged_revision, sizeof(merged_revision), "^%s",
> > +			find_unique_abbrev(a->object.sha1, 40));
> 
> Why do you call find_unique_abbrev(..., 40) here?
> Isn't sha1_to_hex(a->object.sha1) a better solution?

Because I did not know it better at the time I wrote this :) Will be
corrected.

> > +	init_revisions(&revs, NULL);
> > +	rev_opts.submodule = path;
> > +	setup_revisions(sizeof(rev_args)/sizeof(char *)-1, rev_args, &revs, &rev_opts);
> > +
> > +	/* save all revisions from the above list that contain b */
> > +	if (prepare_revision_walk(&revs))
> > +		die("revision walk setup failed");
> > +	while ((commit = get_revision(&revs)) != NULL) {
> > +		struct object *o = &(commit->object);
> > +		if (in_merge_bases(b, (struct commit **) &o, 1)) {
> 
> Why not s/(struct commit **) &o/&commit/ ?

Similar, because I needed objects for the array. Will be corrected.

> > +	 (cd sub &&
> > +	  git rev-parse sub-d > ../expect) &&
> > +	 test_cmp actual expect)
> > +'
> > +
> > +test_expect_success 'merging should conflict for non fast-forward' '
> > +	(cd merge-search &&
> > +	 git checkout -b test-nonforward b &&
> > +	 (cd sub &&
> > +	  git rev-parse sub-d > ../expect) &&
> > +	 test_must_fail 	git merge c 2> actual  &&
> > +	 grep $(<expect) actual > /dev/null &&
> 
> I cannot find the "$(<expect)" construct anywhere else in out test scripts.
> Is it portable? Should we maybe use "$(cat expect)" instead?

I do not know. Just to be sure I will change it to cat.

> Otherwise, it looks good to me. Thanks for the effort!

Thank you as well. The rest of the comments are already incorporated.

cheers Heiko
