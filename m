From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Tue, 26 Aug 2008 01:28:14 +0200
Message-ID: <cb7bb73a0808251628q6af52292sc296fb63565b6eaa@mail.gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <48B1B6F2.5050301@gmail.com> <200808242237.53953.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lea Wiemann" <lewiemann@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@ucw.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 01:31:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXlX6-0003mk-V8
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 01:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbYHYX2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 19:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbYHYX2R
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 19:28:17 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:53076 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbYHYX2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 19:28:16 -0400
Received: by yx-out-2324.google.com with SMTP id 8so992995yxm.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+VtR3BxuSU2CWofP+IlyDbBAOEgxkoqw02ofGjIyU+k=;
        b=aUuO5IM3ff1lAVJNGKyoMFgo7GFeC3S/Fmp8imGgnOgBkqGl7m1xUwUw5ijAtopxZN
         qfVh5pT7EVil0t9XBmyN86iSHfEr8tn1oFk0p/5DffhsYe+iJuQDt4EY2Ct3toJGVW33
         tBn8QdKBLyNxlPUduUsVgjf9XWtiQu6WCUcy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rkTFjfd7veUUvUVdSIWRjcJPH8hcnPq+QtEby1Q/oQmjgnQBn8y/FVS1WipWu6HjEv
         UxjbpqDrBE2C6IMnvfLNpjf2DPMBKI3aT6ZvVl5U4am89KE7bO46waUynJzXoWNTTNlV
         YzIPcEP3uAurReX/L4sSUn0Gz3bJwkw0BuAcE=
Received: by 10.151.114.9 with SMTP id r9mr8007238ybm.201.1219706894583;
        Mon, 25 Aug 2008 16:28:14 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Mon, 25 Aug 2008 16:28:14 -0700 (PDT)
In-Reply-To: <200808242237.53953.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93693>

On Sun, Aug 24, 2008 at 10:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Lea Wiemann wrote:
>> Giuseppe Bilotta wrote:
>> > +                   my $git_type = git_get_type($ref);
>> > [...]
>> > +                           $cgi->a({-href => href(action=>$view{$git_type} || $git_type, hash=>$name)}, $name) .
>>
>> Since some of this thread seems to be about performance, you might just
>> make this a link to action => 'object' (and save the git_get_type call)
>> and let gitweb Do The Right Thing when the link is followed.
>>
>> [Disclaimer: Haven't read the whole thread, and haven't checked if
>> action=object is actually doing the right thing here.]
>
> First, only the first patch (and perhaps second) called git_get_type;
> v4 and v5 do not.  Second, link to 'object' action would not do the
> right thing; we want either 'shortlog' or 'tag' view, not 'commit'
> or 'tag' view.
>
> What this patch does is making ref markers in the log-like views, and
> in the commit subject line headers in other view be "hidden links" to
> either 'shortlog' (in the case of ref being head/branch, or lightweight
> tag), or to 'tag' view in the case of annotated tag.  We rely on the
> fact that we know what type of object refs points to (currently it is
> only 'commit', which might change, but the fact that we know type of
> object for which we show marker would not change), and the fact that
> tags point to given object only indirectly, and only tags can point
> indirectly (^{} suffix in "git show-ref --dereference", and
> "git ls-remote .", and $GIT_DIR/info/refs).

However, Lea's idea has its own merit. I hacked up a patch series that
implements a git_marker_view() function (or fucntion as the shortlog
says 8-P) and *that* one is used for ref markers, you can see it (3
patches) here: http://git.oblomov.eu/git/shortlog/heads/gitweb/shortlog..heads/gitweb/refmark
[it's on top of other stuff but it's actually independent from the
other stuff].

The advantage of this approach is that you actually it's more flexible
in case future expansions lead to other differences in object vs
marker view (currently the only difference is commit => shortlog):
such differences just need to be added to the appropriate %views hash.

The disadvantage is that we don't care about the difference between
lightweight and annotated tags, so there is no more visual difference
about it, something which patch v5 does. This could of course be
addressed separately as needed.

So, should I resend v5 with the small change about refs canonical
form, or is somebody else doing it? Or is the new idea as implemented
in the above mentioned changeset preferrable? Should I send that
patches to the mailing list?

Let me know, I've got plenty more stuff ready for gitweb and I'm eager
to see them accepted upstream 8-D

-- 
Giuseppe "Oblomov" Bilotta
