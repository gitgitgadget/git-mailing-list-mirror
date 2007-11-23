From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Fri, 23 Nov 2007 11:13:55 +0100
Message-ID: <8aa486160711230213q6038037epe2cbd0240db8b612@mail.gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	 <8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com>
	 <7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>
	 <200711231018.49322.jnareb@gmail.com>
	 <7vejehux3y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 11:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvVY7-0002A4-Go
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 11:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbXKWKN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 05:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbXKWKN5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 05:13:57 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:49697 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755154AbXKWKN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 05:13:56 -0500
Received: by rn-out-0102.google.com with SMTP id s46so4179541rnb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1FAeUXeUaZMw7Ed9aHVqmIuKRb6AfoP7f+2mkWAJ2FA=;
        b=TA7HmnNFxiRFWs351O8NryeWhfPJyII7E9hoygOzu2+iBjHpyvIYj7N1bYLFdaVg3W1uYKtlDh8b51shwFcB4gALVgzGJQJwCXo8FK+CxVkCzUl8M5YUrKN0QhZsNoRGTnP6A8PNtuphWqBa7XOo69JilImNSaO0A56yhtofqwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q6Hjd3Ob5Im37UYHUKuV4SI+s4JTK9T7RT5xB/8fHIJ+w+lBZBsDKvKwZ47CynS6LxTulGdCROtYjSz/c7feFAMXC7F+7+vq0abuwCb7Nd8obz/CBHWdF9pdCvJKqaCXKzPeA5hyQBaQrMWApUcTnj+8Su7iWMhYaH0Esmi9dzc=
Received: by 10.150.154.6 with SMTP id b6mr1814774ybe.1195812835345;
        Fri, 23 Nov 2007 02:13:55 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Fri, 23 Nov 2007 02:13:55 -0800 (PST)
In-Reply-To: <7vejehux3y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65890>

On Nov 23, 2007 10:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I was disagreeing with Santi's "'push --bundle' and 'bundle
> create' can be equivalent".  They can't be, as "push" is always
> "update" and never "create".  So I do not quite get your "But for
> that I think"; I think you are just agreeing with me.
>
> Even if we taught "push" to create (which I doubt would happen
> due to its security and administrative implications), it would
> not make the two any closer to being equivalent.  For them to
> become equivalent, we would need to have "push" unlearn how to
> update, which would never happen ;-).
>

OK. So git push will never understand bundles.

My motivation was to have a similar workflow with bundles as with
pushes, or at least as similar as possible. So another possible
workflow would be with a:

git bundle push [<bundle> [<refspec>]]

that creates a bundle

# Have a project with different branches (master, next, pu)
$ git bundle push bundle.bdl
# would create a complete bundle.bdl with all the local branches (with HEAD)

# You send it to the other person and he does:
$ git clone bundle.bdl project
$ cat .git/config
...
[remote "origin"]
        url = /path/to/bundle.bdl
        fetch = +refs/heads/*:refs/remotes/origin/*

# He makes changes, commits and so on and then he wants to send to back a bundle
$ git bundle push [<remote>]
# This creates an incremental bundle with the local branches (with
HEAD) as specified
# by remote.<remote>.* (possibly with an implicit "push" line
"refs/heads/*:refs/heads/*"
# And considering the remotes/origin/* as the bases for the bundle

# Then I got it and do a:
$ git remote add bundle /path/to/bundle
$ git fetch

# Now maybe I just want to send him the master branch
$ git bundle push origin master:master

# If I want to send him a complete bundle
$ git bundle push

The important part, for me, is to keep remote tracking branches to
know the bases for the next bundle. It does not matter if it is "git
push", "git bundle push", "git push --bundle", "git bundle update",
...

Santi
