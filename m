Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012013AC2
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E64BD
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 04:25:48 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 1214D24275;
	Fri, 13 Oct 2023 07:25:46 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qrGIb-U5l-00; Fri, 13 Oct 2023 13:25:45 +0200
Date: Fri, 13 Oct 2023 13:25:45 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Message-ID: <ZSkpOc/dcGcrFQNU@ugly>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g>
 <0E44CB2C-57F2-4075-95BE-60FBFDD3CEE2@icloud.com>
 <xmqqttqvg4lw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqttqvg4lw.fsf@gitster.g>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 09:58:19AM -0700, Junio C Hamano wrote:
>I do not think it will be the end of the world if we don't do so,
>but it would be really really nice if we at least explored a way (or
>two) to make a big enough hole in the syntax to not just add
>"precious", but leave room to later add other traits, without having
>to worry about breaking the backward compatibility again.
>
that would invariably make the syntax more verbose, for dubious gain.

that the extension we're deliberating now (again) was coming (in some 
form) was clear for quite a while, while i'm not aware of anything else 
that would semantically fit gitignore (*). "other traits" sounds awfully 
like scope creep, and would most likely fit gitattributes better.

anyway, such a hypothetical "breaking" change wouldn't have much impact, 
because versioned files aren't affected by gitignore. and for the 
misclassification to be actually harmful, the user would have to be 
unable to notice or correct it.

(*) this got me thinking about things that would fit, and i came up with 
a modification of the proposal: one might want to specify just *how* 
precious a file is (which i guess would translate to how many times the 
extra override option would have to be passed to git-clean). (**)

i guess a suitable syntax for that would be

   2>.config

note that even though using the dollar sign to denote "precious" is kind 
of intuitive, i'm not using it for two reasons: a) it's not "crazy" 
enough to use it at not quite the beginning of a file name (note that 
traditionally it isn't even special on windows), and b) the visual 
separation of the prefix isn't as good as with the "arrow-like" 
character.

(**) actually, one would probably want proper type tagging (e.g., config 
files vs. autotools-generated files (which do not belong into a repo, 
but do into a tar-ball)). that really does sound a lot like 
gitattributes, only that the files aren't versioned.

regards
