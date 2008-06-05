From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [WIP/RFC PATCH 1/2] Introduce GIT_INDEX_PREFIX
Date: Thu, 5 Jun 2008 19:03:35 +0700
Message-ID: <fcaeb9bf0806050503y321b6730l7269443ac84ae8a6@mail.gmail.com>
References: <20080604162825.GB23975@laptop>
	 <7vabi1xepi.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0806042015w72295f07k25ad709f5d976b20@mail.gmail.com>
	 <alpine.DEB.1.00.0806050532240.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 14:05:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ECn-0006g0-IN
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 14:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbYFEMDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 08:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbYFEMDk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 08:03:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:54829 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116AbYFEMDj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 08:03:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so344748fgg.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mmwNjmTM7b4WmsORkpWy0snR0pvEkFu3G0v6C47ybpw=;
        b=xkuISDaHKEEZfGzM06sd1+XMSf7lmNFDTRfzO2a/AoCH5SyhiOPpmyQ3vDsKcAdVHU
         OZAxh8EWWrJwSzWu9YSsohrqpq4HUP6pJ/tWQyx9GYsd64nWvB4GhFTVUBKmSJv9sINz
         +rnQCmpxlmwwmt+dQmjXKe4eWHLzfMi/WKdoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Vls1ohi5GqgWO79CKH6Wxt3LH3KYR48kwuWlQx739R2/8k52jtt9EORugO4VVlZmtN
         DKwKFoTYQRayD1UFeOZVWzi9xvPKBO7jcdTXHf9MocelHKmEpue7acVNEYpq5YRd1cv5
         lR/VTJj4yxnOCQLpBE/oWXlpUjW71Np0EHkYA=
Received: by 10.86.1.11 with SMTP id 11mr1974543fga.27.1212667416016;
        Thu, 05 Jun 2008 05:03:36 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Thu, 5 Jun 2008 05:03:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806050532240.21190@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83910>

On Thu, Jun 5, 2008 at 11:35 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 5 Jun 2008, Nguyen Thai Ngoc Duy wrote:
>
>> On Thu, Jun 5, 2008 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>> >
>> >> GIT_INDEX_PREFIX is used to limit write access to a specific directory.
>> >> Only "important" information is protected by index prefix (those will
>> >> be used to create tree objects)
>> >>
>> >> When GIT_INDEX_PREFIX is set, any attempt to modify the index (refresh
>> >> it is okay though) will bail out. read-tree and merge, however, can
>> >> write to full index. For merge, no conflict is allowed outside index
>> >> prefix.
>> >
>> > This is kind of hard to judge as part of "narrow checkout" series,
>> > because it is not clear how this will actually _help_ narrow checkout.
>>
>> When you do narrow checkout. You only have a subdirectory, so you would
>> not want some commands to accidentally change things outside that
>> subdirectory in index.
>
> When they operate purely on the index?  Why not?

They don't. But if they only operate on a subdirectory only, they must
operate only on that subdirectory in index (exceptions: git-merge and
git-read-tree)

>
> I guess that Junio's point was that the semantics are not at all clear.

On the second thought, I think this series is not a requirement for
narrow checkout. But it does help to
 -  detect any index violation (from unsupported commands)
 - draw an inititial path to index manipulation, needed for narrow
checkout (cache_refresh_ent() will be enhanced not to stat() outside
subtree though)

>
>> > In other words, as a standalone "protect parts outside a single
>> > subdirectory" it can be reviewed and judged, but it is unclear how it
>> > would help narrow checkout if you excempted only a _single_
>> > subdirectory. E.g. you might want to limit yourself to arch/x86 _and_
>> > include/asm-x86.
>>
>> Well it could be extended to support multiple path separated by colon
>> later if someone needs it :)
>
> The thing is: if the concept is sound, chances are that it is _easy_ to
> support that, should someone need it.

It should be easy except check_index_prefix() for multiple index prefixes.

>
>> >> @@ -71,6 +73,9 @@ static void setup_git_env(void)
>> >>       git_graft_file = getenv(GRAFT_ENVIRONMENT);
>> >>       if (!git_graft_file)
>> >>               git_graft_file = xstrdup(git_path("info/grafts"));
>> >> +     index_prefix = getenv(INDEX_PREFIX_ENVIRONMENT);
>> >> +     if (index_prefix && (!*index_prefix || index_prefix[strlen(index_prefix)-1] != '/'))
>> >> +             die("GIT_INDEX_PREFIX must end with a slash");
>> >
>> > Not nice (aka "why 'must'?").
>>
>> Simpler handling. Maybe it should append slash by itself if missing.
>
> Not maybe.  Definitely.  That was what the comment was about.

OK. Definitetly :)

>
>> >> diff --git a/read-cache.c b/read-cache.c
>> >> index ac9a8e7..4f8d44b 100644
>> >> --- a/read-cache.c
>> >> +++ b/read-cache.c
>> >> @@ -23,6 +23,11 @@
>> >>
>> >>  struct index_state the_index;
>> >>
>> >> +static int outside_index_prefix(const struct index_state *istate, const char *ce_name)
>> >> +{
>> >> +     return istate == &the_index && get_index_prefix() && prefixcmp(ce_name, get_index_prefix());
>> >> +}
>> >
>> > The first check above needs to be justified.
>> >
>> > If you say "outside of this path are off-limits", why do you allow a
>> > temporary index that is used during a partial commit and other
>> > index_states excempt from that rule?
>>
>> Because unpack_trees writes new index from scratch so it will always
>> violate that. That check is IMO enough for simple index manipulation
>> like add/remove an entry. For unpack_trees, I have check_index_prefix()
>> to match a temporary index with current index before it gets written to
>> disk.
>
> unpack_trees() is what drives merges.  Does that mean that the only
> opportunity to end up with conflicts is _not_ prevented?

I am not sure I understand this. In my opinion, due to unpack_trees()
behavior, it is free to write to temporary indexes. I don't know if
any channce conflicts will be generated without unpack_trees(). But
then if an index is to be written to .git/index, it must be checked
against .git/index plus index prefix. Any opportunity that ends up
with conflicts does not matter, as long as it will not be written to
.git/index or conflicts are visible in narrow checkout. Otherwise it
must be checked. What I care is that .git/index is controlled, so that
people won't be able to change anything outside index prefix by
accident.

> Ciao,
> Dscho
>
>



-- 
Duy
