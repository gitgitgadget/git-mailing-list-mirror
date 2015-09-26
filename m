From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sat, 26 Sep 2015 14:54:55 -0700
Message-ID: <CAJo=hJuj04nZS3qPe+QcvihoMVJ1JUL7eG5gdVU-V_FPdLn1tQ@mail.gmail.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com> <20150925162615.GF8417@sigill.intra.peff.net>
 <xmqqa8sa4ak4.fsf@gitster.mtv.corp.google.com> <20150925185227.GA15190@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, larsxschneider@gmail.com,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 23:55:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfxRI-000383-O3
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 23:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbbIZVzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 17:55:19 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36566 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932466AbbIZVzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 17:55:15 -0400
Received: by vkfp126 with SMTP id p126so73547535vkf.3
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pjc6OA5Hs3EpKWH3lemFtWw5+5XrMZU1ho/z34lwHXs=;
        b=ACxjpo1sFcttQZYbiQEZzzeWO0HFbWFehXAv4rHETvYFU0oIAD1in1ork661EL8kdh
         8s0ue78T7KlMtdfb5tfjnaNrxCxStKCFiNrz66FqPq96SnSs/hfBXp5Qx3MgadANzTnc
         r19zZ5puPbA4wyQEaZj+Y6mJBPpcMlu+FH6/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=pjc6OA5Hs3EpKWH3lemFtWw5+5XrMZU1ho/z34lwHXs=;
        b=jdy62ItlzFSkJfvyiwu66/iVwZVEGTdY22SiQO0pUlP6eiwi6ZLhrDeokYrng72kcl
         p379sL6QDYwfcXHjNpkAFCeZ5Xb3c8AJZYmMBDDX1uo0zIi3Nc2Hlb85Wvin8Rqskt7a
         hNwlYEyIrII5PqpJqGualzFmvk+aKL/U2eh7DnV+5DftA+aOcjHmIrp+0tToO6AGnmF+
         zyIEL9MpPmox2QPPUDcWBzz/HO2JWvYEVCt76x49HyQdxrkKyEnfZQpEjZswm5syvAN8
         eea2p7a+PRopNnK0WrFYEj1CIRHxpel0dpLD1b56AupEGvlrPCtaR9fGky2OjRDgOgZe
         c3+Q==
X-Gm-Message-State: ALoCoQllgkB43/p4Ykjiv9g61KXSRz42/uNjBFKEGBlvONglDx1K4Zw63LEO88CFzQp405l/tbRe
X-Received: by 10.31.9.212 with SMTP id 203mr7921628vkj.74.1443304514443; Sat,
 26 Sep 2015 14:55:14 -0700 (PDT)
Received: by 10.103.10.65 with HTTP; Sat, 26 Sep 2015 14:54:55 -0700 (PDT)
In-Reply-To: <20150925185227.GA15190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278698>

On Fri, Sep 25, 2015 at 11:52 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 25, 2015 at 11:29:31AM -0700, Junio C Hamano wrote:
>
>> >  So I wonder if it would be
>> > helpful to have a microformat that the client would use to look at this.
>> > E.g., it would fetch the cert tree, then confirm that the current ref
>> > values match the latest cert.
>>
>> Yeah, that is one possibility.  Just a single flat file that
>> concatenates all the push cert in the received order would do as an
>> export format, too ;-)
>
> I agree that's a more logical format, in a sense; it really is a linear
> log. It's just that the receive-pack code already creates a blob for us,
> so it's cheap to reference that in tree (and then fetching it is cheap,
> too). IOW, git is much better at adding files to trees than it is at
> appending to files. :)

FWIW JGit has a micro-format[1] we are starting to use. Its a tree of
the push cert blobs anchored under refs/meta/push-certs.

Inspired by a proposal from gitolite[2], where we store a file in
a tree for each ref name, and the contents of the file is the latest
push cert to affect that ref.

The main modification from that proposal (other than lacking the
out-of-git batching) is to append "@{cert}" to filenames, which allows
storing certificates for both refs/foo and refs/foo/bar. Those
refnames cannot coexist at the same time in a repository, but we do
not want to discard the push certificate responsible for deleting the
ref, which we would have to do if refs/foo in the push cert tree
changed from a tree to a blob.

[1] https://eclipse.googlesource.com/jgit/jgit/+/d5a71e9ca3d95330acdd858306c4f75ae0b01e58
[2] https://github.com/sitaramc/gitolite/blob/cf062b8bb6b21a52f7c5002d33fbc950762c1aa7/contrib/hooks/repo-specific/save-push-signatures
