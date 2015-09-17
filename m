From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Thu, 17 Sep 2015 16:54:25 +0000
Message-ID: <1442508864.21964.26.camel@transmode.se>
References: <1440157010.1759.83.camel@transmode.se>
	 <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
	 <1442245035.10125.18.camel@transmode.se>
	 <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "pclouds@gmail.com" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:54:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccS9-0007Ir-Tt
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbbIQQya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:54:30 -0400
Received: from smtp.transmode.se ([31.15.61.139]:64253 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbbIQQy3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2015 12:54:29 -0400
Received: from exch1.transmode.se (exch1.transmode.se [192.168.201.16])
	by smtp.transmode.se (Postfix) with ESMTP id 400181187067;
	Thu, 17 Sep 2015 18:54:26 +0200 (CEST)
Received: from exch1.transmode.se (192.168.201.16) by exch1.transmode.se
 (192.168.201.16) with Microsoft SMTP Server (TLS) id 15.0.1076.9; Thu, 17 Sep
 2015 18:54:26 +0200
Received: from exch1.transmode.se ([fe80::3029:ce14:7d42:cc5]) by
 exch1.transmode.se ([fe80::3029:ce14:7d42:cc5%17]) with mapi id
 15.00.1076.000; Thu, 17 Sep 2015 18:54:26 +0200
Thread-Topic: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Thread-Index: AQHQ3AWr4MUVkjVcJE+EJNOGRY0lNp4lzPKAgBZf8YCABJAwgIAAPF0A
In-Reply-To: <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.16.5 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.200.4]
Content-ID: <2583014FEE13CF428053B111BCA19880@transmode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278139>

On Thu, 2015-09-17 at 20:18 +0700, Duy Nguyen wrote:
> On Mon, Sep 14, 2015 at 10:37 PM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> > On Mon, 2015-08-31 at 16:56 +0700, Duy Nguyen wrote:
> > > On Fri, Aug 21, 2015 at 6:36 PM, Joakim Tjernlund
> > > <joakim.tjernlund@transmode.se> wrote:
> > > > I cannot push:
> > > > # > git push origin
> > > > Login for jocke@git.transmode.se
> > > > Password:
> > > > Counting objects: 7, done.
> > > > Delta compression using up to 4 threads.
> > > > Compressing objects: 100% (7/7), done.
> > > > Writing objects: 100% (7/7), 13.73 KiB | 0 bytes/s, done.
> > > > Total 7 (delta 4), reused 0 (delta 0)
> > > > fatal: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission
> > > > denied
> > > > fatal: The remote end hung up unexpectedly
> > > > fatal: The remote end hung up unexpectedly
> > > 
> > > Noted. Will try to fix (but probably not fast). At first I thought
> > > this was an old bug, but that old bug [1] is in the fetch/clone path,
> > > not push. Not sure if the same approach can be reused here (i.e.avoid
> > > temp files altoghether).
> > > 
> > > [1] b790e0f (upload-pack: send shallow info over stdin to pack-objects
> > > - 2014-03-11)
> > 
> > Noticed I had forgotten to reply ...
> > 
> > An even simpler fix would be to have an tmp dir within the repo, aka:
> >  /var/git/tmv3-target-overlay.git/tmp/shallow_Un8ZOR
> > This would cover all cases when one must create a tmp file
> 
> Sorry for my silence. I intend to put these temp files in $TMPDIR by
> resurrecting (part of) this patch [1]. Maybe tomorrow.
> 
> But if you build your own, you can put them in $GIT_DIR/tmp by
> replacing "shallow_XXXXXX" in setup_temporary_shallow() in shallow.c
> with "tmp/shallow_XXXX". You need to create the directory "tmp" in
> advance though, or do
> "safe_create_leading_directories_const(git_path("tmp/shallow_XXXXX"));"
> before xmkstemp()

I think you should do both, safe_create_leading_directories_const(git_path("tmp/shallow_XXXXX")) and
TMPDIR.

Anyhow, can you send me a patch when you are done?

  Jocke
