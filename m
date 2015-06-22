From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 06/19] ref-filter: implement '--merged' and
 '--no-merged' options
Date: Mon, 22 Jun 2015 20:41:52 +0530
Message-ID: <CAOLa=ZR3jyxTTKJ=cCWGhW80WHqcHx3Z2bBunzpUbhug-E1oew@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-6-git-send-email-karthik.188@gmail.com>
 <CAPc5daVtMjv=shHhnnR=_p37ND9-64MV-wrsfQA9p2OQ0DbZUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 17:12:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73Od-0007kY-6r
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbbFVPMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:12:23 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34237 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbFVPMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:12:22 -0400
Received: by oigx81 with SMTP id x81so123776710oig.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yaxjGYFlQ2IIEnMdZdIp0kncB80b8vfCHtGr/J9Z01E=;
        b=K+PcSuOiekY8SZkqwX2U9PtS6ozMr34oopi4hnjdS1wNrAPuymRFNpp20yZ5USTORB
         zDt6xikwiVqxhaL5WkXznUhnGevoNlhrJqewUcjl/om/VtqU+F0LwHKohqejn6s8zFct
         10G3NQFt1poSggBsQeC6TGDjzQf18m9Ku9A7W1QUuu4UHUNLqET26T3AFB40n42Fdfkb
         Le9Kp9jBRPlOHCCrkojNZyKnoPPdnjUlI4IQtpYUy17fyq75qa0mKJDFhk2r//TTiUei
         2sZ7BrvRLpHYrRiiY0T6rHP/yKabZuuUw7ifvYWh5pPORIkHSrWwbIcKruqCEN4z9iYi
         2Wrg==
X-Received: by 10.202.186.132 with SMTP id k126mr24216178oif.60.1434985941671;
 Mon, 22 Jun 2015 08:12:21 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 22 Jun 2015 08:11:52 -0700 (PDT)
In-Reply-To: <CAPc5daVtMjv=shHhnnR=_p37ND9-64MV-wrsfQA9p2OQ0DbZUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272369>

On Mon, Jun 22, 2015 at 6:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Sun, Jun 21, 2015 at 1:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> +static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
>> +{
>> +       struct rev_info revs;
>> +       int i, old_nr;
>> +       struct ref_filter *filter = ref_cbdata->filter;
>> +       struct ref_array *array = ref_cbdata->array;
>> +       struct commit_list *p, *to_clear = NULL;
>> +
>> +       init_revisions(&revs, NULL);
>> +
>> +       for (i = 0; i < array->nr; i++) {
>> +               struct ref_array_item *item = array->items[i];
>> +               add_pending_object(&revs, &item->commit->object, item->refname);
>> +               commit_list_insert(item->commit, &to_clear);
>
> Use of commit_list for an array of known number of commits feels somewhat
> wasteful. Couldn't to_clear be
>
>     struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
>
> instread?

Awesome! you're right, will drop the commit_list.
