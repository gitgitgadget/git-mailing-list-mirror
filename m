From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 5/5] builtin-remote: Make "remote -v" display push urls
Date: Tue, 09 Jun 2009 20:07:38 +0200
Message-ID: <4A2EA4EA.1070107@drmicha.warpmail.net>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>	 <1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>	 <1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>	 <1244563298-15479-4-git-send-email-git@drmicha.warpmail.net>	 <1244563298-15479-5-git-send-email-git@drmicha.warpmail.net>	 <1244563298-15479-6-git-send-email-git@drmicha.warpmail.net> <36ca99e90906090925q71ed98f4j23336dabbe199bd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME5k3-0005O6-3x
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbZFISHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 14:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbZFISHm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:07:42 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34254 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537AbZFISHl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 14:07:41 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id EB1A735F220;
	Tue,  9 Jun 2009 14:07:43 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 09 Jun 2009 14:07:43 -0400
X-Sasl-enc: tN5E32ggB1XSE1FGAYHrw8maKOM9qjhJgXYnZBe137C/ 1244570863
Received: from localhost.localdomain (p54859AE3.dip0.t-ipconnect.de [84.133.154.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D8A1035D9F;
	Tue,  9 Jun 2009 14:07:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090609 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <36ca99e90906090925q71ed98f4j23336dabbe199bd8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121197>

> On Tue, Jun 9, 2009 at 18:01, Michael J Gruber<git@drmicha.warpmail.net> wrote:
>> Currently, "remote -v" simply lists all urls so that one has to remember
>> that only the first one is used for fetches, and all are used for
>> pushes.
>>
>> Change this so that the role of an url is displayed in parentheses, and
>> also display push urls.
>>
>> Example with "mjg" having 1 url and 1 pushurl, "origin" having 3 urls,
>> sb having 1 url:
>>
>> mjg     git://repo.or.cz/git/mjg.git (fetch)
>> mjg     repoor:/srv/git/git/mjg.git (push)
>> origin  git://repo.or.cz/git.git (fetch)
>> origin  git://repo.or.cz/git.git (push)
>> origin  git://git2.kernel.org/pub/scm/git/git.git (push)
>> origin  git://repo.or.cz/alt-git.git (push)
>> sb      git://repo.or.cz/git/sbeyer.git (fetch)
>> sb      git://repo.or.cz/git/sbeyer.git (push)

Junio wrote:
> I am debating myself if the last two should be just one line,
> without "(fetch)" nor "(push)" tacked at the end, like this:
> 
>         sb     git://repo.or.cz/git/sbeyer.git
> 
> If we change the rule in your patch to format a remote.*.url used for both
> push and fetch as a single line to achieve this, however, it would make
> your "origin" example come out like this instead:
> 
> 	origin git://repo.or.cz/git.git
>         origin git://git.kernel.org/pub/scm/git/git.git (push)
>         origin git://repo.or.cz/alt-git.git (push)
> 
> which is arguably better (one less line) and worse (it is unclear if the
> top one is only for fetching) at the same time.
> 
> Or perhaps we could go with something like this.
> 
> 	origin git://repo.or.cz/git.git (fetch/push)
>         origin git://git.kernel.org/pub/scm/git/git.git (push)
>         origin git://repo.or.cz/alt-git.git (push)
>         sb     git://repo.or.cz/git/sbeyer.git
> 
> i.e. make the rule such that a URL used for both are shown with (fetch/push)
> only if there are other lines for the same remote.

Bert wrote:
> Wouldn't it be more readable if push|fetch comes first?
> 
> mjg     (fetch) git://repo.or.cz/git/mjg.git
> mjg     (push)  repoor:/srv/git/git/mjg.git
> origin  (fetch) git://repo.or.cz/git.git
> origin  (push)  git://repo.or.cz/git.git
> origin  (push)  git://git2.kernel.org/pub/scm/git/git.git
> origin  (push)  git://repo.or.cz/alt-git.git
> sb      (fetch) git://repo.or.cz/git/sbeyer.git
> sb      (push)  git://repo.or.cz/git/sbeyer.git
> 
> And how about to print only one line for (url_nr == 1 && pushurl_nr == 0):
> 
> mjg     (fetch) git://repo.or.cz/git/mjg.git
> mjg     (push)  repoor:/srv/git/git/mjg.git
> origin  (fetch) git://repo.or.cz/git.git
> origin  (push)  git://repo.or.cz/git.git
> origin  (push)  git://git2.kernel.org/pub/scm/git/git.git
> origin  (push)  git://repo.or.cz/alt-git.git
> sb              git://repo.or.cz/git/sbeyer.git
> 

All this shows why this one is 5/5 and separate ;) I was thinking hard
about the best display also. From my point of view, there are two
arguments against the seemingly more user friendly variants (collapsing
fetch and push entries with the same url):

- It introduces 3 different types of lines, rather than 2.
- The code would have to go through all (push) urls and check whether it
matches url[0].

While the latter one is technical, the first makes it more difficult to
parse the output, both visually and programmatically (I know, porc...).

Note that at least implicitely we always had 2 different types of lines
in the output of "remote -v": the first one (fetch+push) and the others
(push). There is no way to keep only those 2 types (when there is a
"pushurl" setting), my suggestion was to use 2 types now for the 2 purposes.

>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  builtin-remote.c |   27 +++++++++++++++++++++++----
>>  1 files changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin-remote.c b/builtin-remote.c
>> index b350b18..80b2536 100644
>> --- a/builtin-remote.c
>> +++ b/builtin-remote.c
>> @@ -1276,14 +1276,31 @@ static int update(int argc, const char **argv)
>>  static int get_one_entry(struct remote *remote, void *priv)
>>  {
>>        struct string_list *list = priv;
>> +       const char **url;
>> +       int i, url_nr;
>> +       void **utilp;
>>
>>        if (remote->url_nr > 0) {
>> -               int i;
>> -
>> -               for (i = 0; i < remote->url_nr; i++)
>> -                       string_list_append(remote->name, list)->util = (void *)remote->url[i];
>> +               utilp = &(string_list_append(remote->name, list)->util);
>> +               *utilp = malloc(strlen(remote->url[0])+strlen(" (fetch)")+1);
>> +               strcpy((char *) *utilp, remote->url[0]);
>> +               strcat((char *) *utilp, " (fetch)");
> How about using struct strbuf?

I thought it's complicated enough for the little change in output... But
what do strbufs bring us here?
Before the patch, builtin-remote would leak the string_list. They way I
use malloc enables me to free the string list (using string_list_clear)
later on, including the strings and utils. strcpy and strcat look a bit
low level but I see no point in using the sprintf shotgun here.

More or less I have zero clue about strbuf (OK, probably not less...)
but I think that if util is a strbuf then freeing everything would be
more complicated because a strbuf may or may not be allocated.

Michael
