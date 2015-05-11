From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 3/3] cat-file: add --follow-symlinks to --batch
Date: Mon, 11 May 2015 18:31:11 -0400
Organization: Twitter
Message-ID: <1431383471.15048.9.camel@ubuntu>
References: <1431366989-7405-1-git-send-email-dturner@twopensource.com>
	 <1431366989-7405-4-git-send-email-dturner@twopensource.com>
	 <xmqqd2263lxf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 00:31:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrwEJ-0007vD-6H
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 00:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbbEKWbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 18:31:15 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:35272 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbbEKWbO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 18:31:14 -0400
Received: by qcbgu10 with SMTP id gu10so76838625qcb.2
        for <git@vger.kernel.org>; Mon, 11 May 2015 15:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=hFN6sc1HPyHgwvIvG0lzlpqzZRANQU2RxWevPCJLCiM=;
        b=moJj8Vpg+DUTWw4DHPcrv1K0b/92bb1Ub18LbKk8ZkOdrOzyEBmyKA3pzxBzEKAq3+
         y0aNuYC5rddekimw2ilISe4AKgB9EDSmvkRStRJArGkJOkQYfSv8XnJiMZtcxR0fLWPP
         Rs4CmoDEmkmnu7iAFEB2o3qsfjjnLeE3yof/Pscr3u/T4MHMm3m8rHWDHhyRCgPcBPEm
         jHHyh3LapnQqJOEv8bC5AVBz1nrWMl6/ZMnAExpiUwpTw/CifESRqGou3tmxTa0zT3W3
         nOy9uVhABo5oaDs0etCTmOueajzcxXft7fRMCCHIdtCeB/lc9YvvMyN2tJPGvpFHImQG
         +M4w==
X-Gm-Message-State: ALoCoQkkMiRtWSTzu63139eQi7lxsqco6LUktnU115wzOa/yvKJCWiok/5g9DGxFs2OtK5/MDYSE
X-Received: by 10.140.144.67 with SMTP id 64mr17000479qhq.40.1431383473691;
        Mon, 11 May 2015 15:31:13 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id g34sm11822319qgd.0.2015.05.11.15.31.12
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 15:31:13 -0700 (PDT)
In-Reply-To: <xmqqd2263lxf.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268826>

On Mon, 2015-05-11 at 13:21 -0700, Junio C Hamano wrote:
dturner@twopensource.com writes:
> 
> > +--follow-symlinks::
> > +	Follow symlinks inside the repository.  Instead of providing
> > +	output about the link itself, provide output about the linked-to
> > +	object.  This option requires --batch or --batch-check.  In the
> > +	event of a symlink loop (or more than 40 symlinks in a symlink
> > +	resolution chain), the file will be treated as missing.  If a
> > +	symlink points outside the repository (e.g. a link to /foo or a
> > +	root-level link to ../foo), the portion of the link which is
> > +	outside the repository will be printed.  Follow-symlinks will
> > +	be silently turned off if <object> specifies an object in the
> > +	index rather than one in the object database.
> 
> One thing that I found is missing from the above and other places in
> the documents updated by this patch, when I pretend that I am an
> end-user who never saw the discussion for the problem definition and
> design of the solution on the list, is what "symlink" this refers
> to and how I am expected to use this feature.
> 
I'll send something like this when I re-roll:

Follow symlinks inside the repository when requesting objects with
extended SHA-1 expressions of the form tree-ish:path-in-tree. Instead of
providing output about the link itself, provide output about the
linked-to object.  This option requires --batch or	--batch-check.  In
the event of a symlink loop (or more than 40 symlinks in a symlink
resolution chain), the file will be treated as missing.  If a symlink
points outside the tree-ish (e.g. a link to /foo or a root-level link
to ../foo), the portion of the link which is outside the tree will be
printed. Follow-symlinks will be silently turned off if <object>
specifies an object in the index rather than one in the object database.

I could also provide some examples, if you think this would be useful.

> +If --follow-symlinks is used, and a symlink in the repository points
> > +outside the repository, then `cat-file` will ignore any custom
format
> > +and print:
> > +
> > +------------
> > +symlink SP <size> LF <symlink> LF
> > +------------
> 
> A symlink contain LF, obviously, and we should use some quoting
> convention.  Perhaps quote_c_style() on a string that needs it is
> sufficient---most sane people do not put LF or literally '\' 'n' or
> '"' in their symbolic links, so the ugly output is not visible for
> them, and it is far better to be able to say "If you have funny
> characters in your symlinks, they will be quoted" than "If you have
> funny characters in your symlinks, you are SOL".
> 
There is no need for quoting because <size> is sufficient to
disambiguate the parsing (just as is the case for blobs, which might
contain arbitrary characters).
