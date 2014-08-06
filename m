From: Jeff King <peff@peff.net>
Subject: Re: Apple violating git LGPL?
Date: Wed, 6 Aug 2014 16:51:45 -0400
Message-ID: <20140806205145.GB22592@peff.net>
References: <CAC_jL3wO9jkE4HapvJjn-4uW4RtSxubFthrxzQJ87EQ4Gq-9Ug@mail.gmail.com>
 <20140806184304.GB21254@peff.net>
 <53E287D4.1050106@baywinds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert P Fischer <rpf2116@columbia.edu>, git@vger.kernel.org
To: Bruce Ferrell <bferrell@baywinds.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:51:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF8Bc-00046w-FI
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 22:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbaHFUvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 16:51:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:47232 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752588AbaHFUvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 16:51:48 -0400
Received: (qmail 14035 invoked by uid 102); 6 Aug 2014 20:51:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Aug 2014 15:51:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Aug 2014 16:51:45 -0400
Content-Disposition: inline
In-Reply-To: <53E287D4.1050106@baywinds.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254904>

On Wed, Aug 06, 2014 at 12:53:56PM -0700, Bruce Ferrell wrote:

> On 08/06/2014 11:43 AM, Jeff King wrote:
> 
> snippage here 8< >8
> >As it happens, though, they _do_ modify the git that they distribute. I
> >know at least that they bake-in the osxkeychain helper config in away that
> >the user cannot turn off. There may be more changes, but I haven't done a
> >full diff. And they do provide the source:
> >https://www.opensource.apple.com/source/Git/

> Is that a plugin?  if not what about proprietary plugins? How are they
> affected by the license is this case?

I don't know exactly what you mean by "plugin" here.

osxkeychain is a separate program found in git's contrib directory.  You
point git at it by setting your credential.helper config to
"osxkeychain". However, in the Apple version, they have hardcoded that
config into the git binary, and you can't turn it off (you can add
additional helpers, but you can't undo the keychain helper). So I don't
think there is any licensing question about what they have done[1].

I do not know offhand of any proprietary credential helpers.  They do
interact with git over a pipe, and their primary function is to feed
data to git. My understanding is that there are some people who believe
that makes them derivative works of git (i.e., that talking RPC over a
pipe to avoid linking does not get around the GPL), but there are others
who would consider them separate programs.

-Peff

[1] Whether what they have done is smart is another matter. I looked at
    the diff Apple's Git-48 and v1.8.5.2 (on which it seems to be
    based).  There aren't a huge number of changes, but some of them
    baffle me. Why bake-in credential.helper when you can set it in
    /etc/gitconfig? Why default core.trustctime to false when you can
    set it via /etc/gitconfig?  Etc. I wish they would work with the
    configurability tools that we already provide, and if those are not
    sufficient, work with us to make git more configurable. But AFAIK
    whoever is responsible for those changes has never participated on
    the mailing list.
