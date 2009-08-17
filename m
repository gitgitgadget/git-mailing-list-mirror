From: skillzero@gmail.com
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 01:49:31 -0700
Message-ID: <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>
	 <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 10:49:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McxuU-0003LJ-Lv
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 10:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757454AbZHQItb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 04:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757401AbZHQItb
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 04:49:31 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:37915 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757389AbZHQIta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 04:49:30 -0400
Received: by qw-out-2122.google.com with SMTP id 8so946790qwh.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kjyT/kg3tpQX5cFgAUz4DXnMJMTigYJNo1tChlJQmtU=;
        b=YRZdjIAiO4EdBIhwW8Mxw3Ca55Dr1+L5175l7L0cUYE0KIqWpUxOSXfFdCNAeuaViF
         N1bl973LhB8DL9ImvnOvXOqTPIpl6FEmyXG8SiCPPt84nACBhhcZF58kvjultN21Ufyq
         4FvC+1HF6puJkZsLLLPKKhqvHQVoTknNpgSaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uJNhTA1VpcS2LkVihFEES/eqcw/ZviUxoOaXYNHTyfU5cktrV9kPP1KaXjNgou2M7h
         5kXmWVQnZWmLqcHH1Gwa55rMbTW5CY88nmD6hMSHlWFGnev0lgXGSUoANBUekh6oYSal
         A3R7YqnX5R2eSmOG4fK98oRF+mcx6bfM3GRkU=
Received: by 10.224.36.104 with SMTP id s40mr4008423qad.296.1250498971576; 
	Mon, 17 Aug 2009 01:49:31 -0700 (PDT)
In-Reply-To: <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126143>

On Mon, Aug 17, 2009 at 1:17 AM, Nguyen Thai Ngoc Duy<pclouds@gmail.com> wrote:
> On Mon, Aug 17, 2009 at 1:09 PM, <skillzero@gmail.com> wrote:
>> 1. Have people decided whether it should be on by default if you have
>> a .git/info/sparse file? I'd definitely like it to be on by default.
>> When I first tried it, I didn't realize I had to use --sparse to git
>> checkout to get it to use the sparse rules. The same goes for a merge
>> I did that happened to have a file in the excluded area (it included
>> it because I didn't use --sparse to git merge).
>
> I tend to make it enabled by default too. I have made it stricter to
> trigger reading sparse in unpack_trees() -- only do it when
> unpack_opts.update is TRUE. This should make it safer to be enabled by
> default.

Other than it being new and not-widely-tested code, is there any
additional risk to having it enabled by default if there are no sparse
patterns defined?

It would be nice if .git/info/sparse is there by default (like
.git/info/exclude) with some commented out instructions (also like
.git/info/exclude).

>> 2. Is it not hooked up to git reset yet? I did a git checkout --sparse
>> and things look liked I expected then I did a git reset --hard
>> origin/master and it started checking out all the stuff previously
>> excluded via .git/info/sparse. I tried --sparse, but it didn't know
>> about that option.
>
> Because sparse was disabled by default, and "git reset" did not enable
> it. It'd be interesting to see what "git reset --hard" should do in
> this case: will it apply .git/info/sparse or not, which brings us back
> to the "default or not" question, hmm..

It seems like if it's going to be off by default (which it hopefully
won't be) then git reset would need to support --sparse since
otherwise, you'd never be able to git reset without undoing your
sparse options (unless you did a subsequent git checkout --sparse).

I also noticed that after I did the git reset, the sparse stuff seemed
to get into a weird state such that sparse patterns weren't working
reliably. For example, I couldn't get it to exclude a directory.

>> 3. One thing that was confusing is that I needed a trailing slash on
>> directories in .git/info/sparse to get them excluded. This seems
>> different than .gitignore, which works for me without the trailing
>> slash.
>
> Hmm.. probably because Git feeds directories to .gitignore handling
> functions. There is not much I can do, index does not have
> directories. I don't know if it's worth generating "directories" from
> index.

Maybe just add a note in the documentation? If there's a default
.git/info/sparse file then it might be good place to put a note as
well.
