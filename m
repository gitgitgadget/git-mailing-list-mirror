From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Sun, 22 Sep 2013 00:08:39 +0300
Message-ID: <20130921210839.GA21974@redhat.com>
References: <20130831194425.GA14706@redhat.com>
 <xmqqioyhu8wd.fsf@gitster.dls.corp.google.com>
 <20130903210815.GB24480@redhat.com>
 <20130915074900.GA30438@redhat.com>
 <20130915080830.GA30465@redhat.com>
 <xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
 <20130917164226.GB20672@redhat.com>
 <xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 23:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNUNo-0005fb-Bl
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 23:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab3IUVGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 17:06:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462Ab3IUVGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 17:06:24 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8LL6M0Y006592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 21 Sep 2013 17:06:23 -0400
Received: from redhat.com (vpn1-6-218.ams2.redhat.com [10.36.6.218])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8LL6LT5023660;
	Sat, 21 Sep 2013 17:06:21 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235147>

On Tue, Sep 17, 2013 at 10:24:19AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > So might it not be useful to tweak patch id to
> > sort the diff, making it a bit more stable?
> 
> That is one thing that needs to be done, I think.  But it would be
> unfortunate if we have to do that unconditionally, though, as we may
> be "buffering" many hundred kilobytes of patch text in core.  If we
> can do so without regressing the streaming performance for the most
> common case of not using the orderfile on the generating side (hence
> not having to sort on the receiving end), it would be ideal.  I am
> not sure offhand how much code damage we are talking about, though.
> 
> > I'll be glad to help do this if you tell me what these parts are.
> > anything else besides fixing besides the stand-alone patch id?
> 
> Off the top of my head I do not think of one (but that is not a
> guarantee that there isn't any).

Okay so I did this by reworking the internal algorithm used by the
stand-alone patch-id (hope you've seen this mail).
Now, a question: does it matter whether the algorithm used by diff_get_patch_id
is different?
Does something rely on them being the same?

If yes, we'd have to change diff_get_patch_id as well.
