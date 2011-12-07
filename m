From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: Re: Suggestion on hashing
Date: Tue, 06 Dec 2011 17:44:36 -0800
Message-ID: <1323222276.1705.434.camel@yos>
References: <1322813319.4340.109.camel@yos>
	 <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
	 <alpine.DEB.2.00.1112060146121.15104@hoki.goeswhere.com>
	 <CACsJy8CM8xqWxTx14QbY+-bT=306p3U=6gJfRaW=dDD-Swo7-w@mail.gmail.com>
	 <1323151347.1745.73.camel@yos>
	 <CACsJy8CXkz-W3Z3pX-C-+fjLz=WahBajE2uLEG-f3gG_svEhug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Chris West (Faux)" <faux@goeswhere.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 02:44:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY6Z0-0001WJ-GB
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 02:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab1LGBop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 20:44:45 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52104 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab1LGBoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 20:44:44 -0500
Received: by ggnr5 with SMTP id r5so56242ggn.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 17:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=Cc2lP8FrF9qvW+Ov+HIIPaewYtU2IKu8onZG7RmBIkc=;
        b=BJPZqh0X+0HFFRlW8KH5qlZqHmPl5n2VrI5o7313dWFZ8m2ID9xB13I1STFXTo5L7v
         vyWzVfWdz6YTu15t59lMw8y11WvCDDaY7BsZxx5R8WHcIKB7HVw3uc7VpXF/8XTS3T1S
         ZG8Ogdl2RZj6MLuS3RkY4jD+t71Z/PcYe8mt4=
Received: by 10.50.236.5 with SMTP id uq5mr17703308igc.47.1323222283828;
        Tue, 06 Dec 2011 17:44:43 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id e2sm527433ibe.0.2011.12.06.17.44.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 17:44:41 -0800 (PST)
In-Reply-To: <CACsJy8CXkz-W3Z3pX-C-+fjLz=WahBajE2uLEG-f3gG_svEhug@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186411>

On Tue, 2011-12-06 at 13:23 +0700, Nguyen Thai Ngoc Duy wrote:
> On Tue, Dec 6, 2011 at 1:02 PM, Bill Zaumen <bill.zaumen@gmail.com> wrote:

> > If you are replacing SHA-1 as an object ID with another hash function,
> > two things to watch are submodules and alternative object databases.
> > Because of those, it is necessary to worry about the order in which
> > repositories are converted.  In the worst case for submodules, you'd
> > have to do multiple repositories at the same time, switching between
> > them depending on what you need at each point.
> 
> I know migration would be painful. But note that new repos can benefit
> stronger digest without legacy (of course until it links to an old
> repo). For submodules, I think we should extend it to become something
> similar to soft-link: git link is an SHA-1 to a text file that
> contains SHA-1 and maybe other digests of the submodule's tip.

Repositories would need to store a table mapping old SHA-1 values to
the new ones (for commits).  There's nothing in a repository to
reliably indicate that it is being used as a submodule, and the choice
of submodules can vary from commit to commit, making it difficult to
control the order in which objects have their hashes updated.  In some
corner cases, you could have two branches in each of two repositories
with different choices as to which is a submodule of which, although
I'd be surprised if anyone actually did that.

Aside from that, in some corporate environments, the IT departments
want to determine the release schedule for applications, and would
take a dim view of changes that could not be tested first without being
widely deployed.  You could end up making Git unacceptable for those
departments if you do not maintain backwards compatibility with
existing repositories.
