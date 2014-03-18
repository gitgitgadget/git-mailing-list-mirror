From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 18 Mar 2014 00:17:39 -0400
Message-ID: <20140318041739.GA7252@sigill.intra.peff.net>
References: <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
 <20140311014945.GB12033@sigill.intra.peff.net>
 <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
 <20140311200513.GB29102@sigill.intra.peff.net>
 <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
 <20140311203650.GA31173@sigill.intra.peff.net>
 <CACsJy8AZ0CfqHRYDrnQD+z0ibVQnsFuSzktEHKRhCVwaXPQryg@mail.gmail.com>
 <CAJo=hJvy6KKMNT9iyZAnKy18Pa+rQkKPQtfqT1e+ddXoVwX0yg@mail.gmail.com>
 <CACsJy8DtuCCYmmsEFB_m-YPHOOQ4FuchvnYQeuv75-vcSMej_w@mail.gmail.com>
 <CAJo=hJuGBgkseQ_mvbxFnYbkFDDWEuassf2+ttj_F53AMzU_Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 05:17:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPlTG-0005qD-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 05:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbaCRERn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 00:17:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:41597 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750835AbaCRERm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 00:17:42 -0400
Received: (qmail 18321 invoked by uid 102); 18 Mar 2014 04:17:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Mar 2014 23:17:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Mar 2014 00:17:39 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJuGBgkseQ_mvbxFnYbkFDDWEuassf2+ttj_F53AMzU_Nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244324>

On Fri, Mar 14, 2014 at 05:09:45PM -0700, Shawn Pearce wrote:

> On Fri, Mar 14, 2014 at 4:30 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Fri, Mar 14, 2014 at 11:45 PM, Shawn Pearce <spearce@spearce.org> wrote:
> >>
> >> You missed the SSH case. It doesn't have this slot to hide the data into.
> >
> > Right now we run this for ssh case: "ssh <host> git-upload-pack
> > <repo-path>". New client can do this instead
> >
> > ssh <host> git-upload-pack <repo-path> <client capability flags>
> 
> Older servers will fail on this command, and the client must reconnect
> over SSH, which may mean supplying their password/passphrase again.
> But its remembered that the uploadPack2 didn't work so this can be
> blacklisted and not retried for a while.

I wonder if we could use the environment for optional values. E.g., can
we run:

  ssh host GIT_CAPABILITIES=... git-upload-pack <repo-path>

That will not work everywhere, of course. Sites with git-shell will
fail, as will sites with custom ssh handler (GitHub, for example, and I
imagine Gerrit sites, if they support ssh). So we'd still need some
fallback, but it would work out-of-the-box in a reasonable number of
cases (and it is really not that different than the http case, which is
just stuffing the values into $QUERY_STRING anyway :) ).

-Peff
