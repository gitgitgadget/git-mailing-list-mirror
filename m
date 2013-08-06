From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: add shared repo upgrade
Date: Tue, 6 Aug 2013 08:22:19 +0200
Message-ID: <CALWbr2wynb-K-r0sehuBUtmkbgp9Ev5iYK_v2ZFxsjcewTCmfQ@mail.gmail.com>
References: <1375730567-3240-1-git-send-email-apelisse@gmail.com>
	<7vwqnzj1gp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Joern Hees <dev@joernhees.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 08:22:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6af2-00014k-J7
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 08:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab3HFGWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 02:22:20 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:57601 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792Ab3HFGWU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 02:22:20 -0400
Received: by mail-qc0-f170.google.com with SMTP id d10so2217669qcz.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 23:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FuZZUhEV1m3imgs6i3Jl0D171CYfPQwGkSibNKYFkYM=;
        b=v6NZwp2m9v86RWvA8/9GhghFTx1PSlbANhXb/lXS9/TJQJJxrmQuNqHQKEjpvdy56U
         uEVXkxIpcOCzheYA/HIWOamfsX8NL7hUsDxjg3dT2Ll1wonjwNRBiRGhpx+oXp2P4nmv
         BlinQVY0TnVyqMypATN58SLIhukccaWvpGW4ghkZ+8Xy0SEWEMQzrfAZxcSK7fq8yvRF
         4o8z+xJM/Xy3oZctmWHU59M0hSt2oMUbPUCrjIsRJP7nUDGBr4S+8lJMTVI7cqZU80P5
         8J39OqsUuBmdniNZaK90HDOQjgdHI0lzLeawd5PmA9tcA+qtMw+tKMWiUWHfXpYOdX50
         G5Tw==
X-Received: by 10.229.12.68 with SMTP id w4mr3305264qcw.39.1375770139499; Mon,
 05 Aug 2013 23:22:19 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Mon, 5 Aug 2013 23:22:19 -0700 (PDT)
In-Reply-To: <7vwqnzj1gp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231722>

On Mon, Aug 5, 2013 at 11:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
> Is the untold
> and obvious-to-those-who-are-familiar-with-this-codepath assumption
> that it is guaranteed that there is at most one "*/clone/.hg" under
> shared_path?

No, there is no such assumption.
That is why we create a repository just below if it doesn't exist (no
copy was found).
That's also why I don't see how we could split the patch.

We could improve that part of the commit message:

    It's trivial to upgrade to the new organization by copying the Mercurial
    repo from one of the remotes (e.g. 'origin'), so let's do so. If
we can't find
    any existing repo, we create an empty one.

>> +        # setup shared repo (if not there)
>> +        try:
>> +            hg.peer(myui, {}, shared_path, create=True)
>> +        except error.RepoError:
>> +            pass
>>
>>          if not os.path.exists(dirname):
>>              os.makedirs(dirname)
