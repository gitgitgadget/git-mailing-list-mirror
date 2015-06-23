From: David Turner <dturner@twopensource.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 13:29:01 -0400
Organization: Twitter
Message-ID: <1435080541.28466.13.camel@twopensource.com>
References: <1435020656.28466.8.camel@twopensource.com>
	 <xmqqvbefdm0d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:29:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7S0T-0007i7-I7
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 19:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbbFWR3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 13:29:05 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35145 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbFWR3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 13:29:03 -0400
Received: by qgeu36 with SMTP id u36so5596802qge.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 10:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=U7PKVc96UtR+bGQbMnJ3N/vm/dmfYbsfXLhGVS22Hm8=;
        b=JJasHmEsqAeStPU8z7Ff4DXuTT2z33j2ZWqHHpHddYFhKmMif3be5bUHMinTyHjfoR
         Y9u6WSCbdknhaLWT4WLF7x3DGCngKw5YgsYUWRGcXBQQm4RW0J++lsmoQ0aPhLAhVSqa
         QqycVv2Rv6Ls8p4rGU9UNt7hSTBF2ryGSkAYsDTCM2OinFN1ch8HR77LPTYjN6qiECvK
         +Mcv6L59ueY1OsVQB1DZAQ3lnaFPkJz8ERy65SvXYwZwCT3tEJ71lNcIWez807Q+qmFd
         UZF8r35ksf/m0Kz7BakNLegAxrjo+GPEOrLrvk+88kqvLcTg/uFlo+IRTunfUrAPqQMM
         wmMg==
X-Gm-Message-State: ALoCoQkPpr/T3VySXUNIgZkoab4SDzwcIZIQEq0pqhzjM8VjQU5O+DSr18xJ/0xn+7GCQAxnralb
X-Received: by 10.140.236.22 with SMTP id h22mr46881288qhc.92.1435080542942;
        Tue, 23 Jun 2015 10:29:02 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id b196sm101490qka.14.2015.06.23.10.29.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 10:29:02 -0700 (PDT)
In-Reply-To: <xmqqvbefdm0d.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272463>

On Mon, 2015-06-22 at 22:36 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > I've revived and modified Ronnie Sahlberg's work on the refs db
> > backend.  
> >
> > The work is on top of be3c13e5564, Junio's "First batch for 2.5 cycle".
> > I recognize that there have been changes to the refs code since then,
> > and that there are some further changes in-flight from e.g. Michael
> > Haggerty.  If there is interest in this, I can rebase once Michael's
> > changes land.
> > ...
> > The db backend runs git for-each-ref about 30% faster than the files
> > backend with fully-packed refs on a repo with ~120k refs.  It's also
> > about 4x faster than using fully-unpacked refs.  In addition, and
> > perhaps more importantly, it avoids case-conflict issues on OS X.
> >
> > I chose to use LMDB for the database...
> > ...
> > Ronnie Sahlberg's original version of this patchset used tdb.  The
> > advantage of tdb is that it's smaller (~125k).  The disadvantages are
> > that tdb is hard to build on OS X.  It's also not in homebrew.  So lmdb
> > seemed simpler.
> 
> "If there is interest"?  Shut up and take my money ;-)
> 
> More seriously, that's great that you stepped up to resurrect this
> topic.  In a sense, the choice of sample database backend does not
> matter.  I do not care if it is tdb, lmdb, or even Berkeley DB as
> long as it functions. ;-)
> 
> As long as the interface between ref-transaction system on the Git
> side and the database backend is designed right, your lmdb thing can
> serve as a reference implementation for other people to plug other
> database backends to the same interface, right? 

Yes.

>  As one step to
> validate the interface to the database backends, it would be nice to
> eventually have at least two backends that talk to meaningfully
> different systems, but we have to start somewhere, and "for now we
> have lmdb" is as good a place to start as any other db backend.
> 
> I wonder if we can do a "filesystem" backend on top of the same
> backend interface---is that too much impedance mismatch to make it
> unpractical?

The patch series does include a filesystem backend, which is simply the
current ref infrastructure with extremely minor changes.  
