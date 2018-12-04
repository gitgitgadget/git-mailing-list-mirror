Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31AB211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 21:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLDVpf (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 16:45:35 -0500
Received: from mout.web.de ([217.72.192.78]:54437 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeLDVpf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 16:45:35 -0500
Received: from [192.168.178.36] ([79.237.241.17]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRUBA-1gwnhc2wIq-00Sfyv; Tue, 04
 Dec 2018 22:45:16 +0100
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick existence
 check
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
 <87ftw62sld.fsf@evledraar.gmail.com>
 <20181112162150.GB7612@sigill.intra.peff.net>
 <87d0ra2b3z.fsf@evledraar.gmail.com> <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
 <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
 <20181203220424.GA11883@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fe388ba5-765e-ff83-e610-d40964a76a0c@web.de>
Date:   Tue, 4 Dec 2018 22:45:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181203220424.GA11883@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:srKllG5lg3SjXg/y1gukHkjjYpTapK3XBXaKPhhaLt3VajsD0l2
 xPen6hd7LDzEj+hqGuDh+iSN78a3KPplOtoj6dMsDn76SPjrvsGWhJqGw2J1apbd8+gwmBe
 Ii4Y0fHaW6DVYekQ67trca+hlTHAHdSAkvkHZdQ/MBEi3UVj+H9JiepoWhalrK1ot0KRFhk
 jNjPdJLKwJ66TiGjHxjPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K9SLnZBg5Ck=:UiMPuqBoX50GLNg9O2RcHi
 myukzqV4JDw8i4kypgaBCzKmZsCg7XF/0Yy5csMb49+TZMPqpRB+m+5nLL0kO+xf+1z40SyDv
 iB2w7E3XZs3Jp6Kzvc+m4VELKtH2f8L+BXxz2cYdmFykUEhc1FMGi9OEaj4OE/tv7h1BaMt0V
 /uXIuH/QIFn82b3wHQk6zTebE9E8UkL73XpRobnj2ZYWVLGLGps3bqiz36brgZJyFGpk5WDY5
 27bTTIZ6no8aLbi/5Ci6J8ELTbASptxCc/FMSLUAAXuWZZcJGYQQ0bOBu+IJuCmPHkV9n9H72
 mQpZhgWR4saxLMSbC8y1IbIt4sHDWcuPzkGDSgZf6a9R7S1NtVh4CTXM1Ki7Cd/gPCuA/EYZg
 +Ity/jRnqk1UyemaSySkk55Kt9rum64R8TXRgvTxyhK/dGRFR2XpXS+C7eYMnbhZ/8vyYhmZ4
 W2qJCYIBNcQcN/PhTNeIsM/ObCHCmDv2RWGj+sYIx0V3cA94+bBz5IS+GOqj6LucVuraLTMX7
 uzFgAcfQf74iPwDjfDfkiE+WX79F0IE3VW0sabqcNqZ+WZfdY23XJI3M2vovAS6fQTnS5CSag
 6HL0/0pO+Va2IUYGJP02WX60gZlX4+P95DeQUjPX60q1Xf034+tC3D1FQ+Ti8X7+qo91IDrrE
 g4zCAVBgHcALFWfL1XlbKEBQwP8B/frj3lzc5/ScUQQ+YkMVVvoXQLyXvmRH9E+xtx6WDeyKe
 uz3SDsn+R3tPSrKDhNu1hF31RJBBao6oKmCfcxR/iMIpTcCj+6L3HaqzvnM4chAxRyy7E8jAk
 7UDq686e4jI6ImsXizYG4MxM77SoCklSgHTG10AqulVH6fekx076okhRY4jkPtmOD5k+oZjQ3
 r37EpLBIdL8icZhfx97PjAlfiVDLCHrFYy1/xk0VqRxp4vVNoiJgbWxIq/2TT+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.2018 um 23:04 schrieb Jeff King:
> On Sun, Dec 02, 2018 at 11:52:50AM +0100, René Scharfe wrote:
> 
>>> And for mu.git, a ~20k object repo:
>>>
>>>     Test                                             origin/master     peff/jk/loose-cache       avar/check-collisions-config
>>>     -------------------------------------------------------------------------------------------------------------------------
>>>     0008.2: index-pack with 256*1 loose objects      0.59(0.91+0.06)   0.58(0.93+0.03) -1.7%     0.57(0.89+0.04) -3.4%
>>>     0008.3: index-pack with 256*10 loose objects     0.59(0.91+0.07)   0.59(0.92+0.03) +0.0%     0.57(0.89+0.03) -3.4%
>>>     0008.4: index-pack with 256*100 loose objects    0.59(0.91+0.05)   0.81(1.13+0.04) +37.3%    0.58(0.91+0.04) -1.7%
>>>     0008.5: index-pack with 256*250 loose objects    0.59(0.91+0.05)   1.23(1.51+0.08) +108.5%   0.58(0.91+0.04) -1.7%
>>>     0008.6: index-pack with 256*500 loose objects    0.59(0.90+0.06)   1.96(2.20+0.12) +232.2%   0.58(0.91+0.04) -1.7%
>>>     0008.7: index-pack with 256*750 loose objects    0.59(0.92+0.05)   2.72(2.92+0.17) +361.0%   0.58(0.90+0.04) -1.7%
>>>     0008.8: index-pack with 256*1000 loose objects   0.59(0.90+0.06)   3.50(3.67+0.21) +493.2%   0.57(0.90+0.04) -3.4%
>>
>> OK, here's another theory: The cache scales badly with increasing
>> numbers of loose objects because it sorts the array 256 times as it is
>> filled.  Loading it fully and sorting once would help, as would using
>> one array per subdirectory.
> 
> Yeah, that makes sense. This was actually how I had planned to do it
> originally, but then I ended up just reusing the existing single-array
> approach from the abbrev code.
> 
> I hadn't actually thought about the repeated sortings (but that
> definitely makes sense that they would hurt in these pathological
> cases), but more just that we get a 256x reduction in N for our binary
> search (in fact we already do this first-byte lookup-table trick for
> pack index lookups).

Skipping eight steps in a binary search is something, but it's faster
even without that.

Just realized that the demo code can use "lookup" instead of the much
more expensive "for_each_unique" to sort.  D'oh!  With that change:

  for command in '
      foreach (0..255) {
        $subdir = sprintf("%02x", $_);
        foreach (1..$ARGV[0]) {
          printf("append %s%038d\n", $subdir, $_);
        }
        # intermediate sort
        print "lookup " . "0" x 40 . "\n";
      }
    ' '
      foreach (0..255) {
        $subdir = sprintf("%02x", $_);
        foreach (1..$ARGV[0]) {
          printf("append %s%038d\n", $subdir, $_);
        }
      }
      # sort once at the end
      print "lookup " . "0" x 40 . "\n";
    ' '
      foreach (0..255) {
        $subdir = sprintf("%02x", $_);
        foreach (1..$ARGV[0]) {
          printf("append %s%038d\n", $subdir, $_);
        }
        # sort each subdirectory separately
        print "lookup " . "0" x 40 . "\n";
        print "clear\n";
      }
    '
  do
    time perl -e "$command" 1000 | t/helper/test-tool sha1-array | wc -l
  done

And the results make the scale of the improvement more obvious:

  256

  real    0m3.476s
  user    0m3.466s
  sys     0m0.099s
  1

  real    0m0.157s
  user    0m0.148s
  sys     0m0.046s
  256

  real    0m0.117s
  user    0m0.116s
  sys     0m0.051s

> Your patch looks good to me. We may want to do one thing on top:
> 
>> diff --git a/object-store.h b/object-store.h
>> index 8dceed0f31..ee67a50980 100644
>> --- a/object-store.h
>> +++ b/object-store.h
>> @@ -20,7 +20,7 @@ struct object_directory {
>>  	 * Be sure to call odb_load_loose_cache() before using.
>>  	 */
>>  	char loose_objects_subdir_seen[256];
>> -	struct oid_array loose_objects_cache;
>> +	struct oid_array loose_objects_cache[256];
> 
> The comment in the context there is warning callers to remember to load
> the cache first. Now that we have individual caches, might it make sense
> to change the interface a bit, and make these members private. I.e.,
> something like:
> 
>   struct oid_array *odb_loose_cache(struct object_directory *odb,
>                                     int subdir_nr) 
>   {
> 	if (!loose_objects_subdir_seen[subdir_nr])
> 		odb_load_loose_cache(odb, subdir_nr); /* or just inline it here */
> 
> 	return &odb->loose_objects_cache[subdir_nr];
>   }

Sure.  And it should take an object_id pointer instead of a subdir_nr --
less duplication, nicer interface (patch below).

It would be nice if it could return a const pointer to discourage
messing up the cache, but that's not compatible with oid_array_lookup().

And quick_has_loose() should be converted to object_id as well -- adding
a function that takes a SHA-1 is a regression. :D

René

---
 object-store.h |  8 ++++----
 sha1-file.c    | 19 ++++++++-----------
 sha1-name.c    |  4 +---
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/object-store.h b/object-store.h
index ee67a50980..dd9efdd276 100644
--- a/object-store.h
+++ b/object-store.h
@@ -48,11 +48,11 @@ void add_to_alternates_file(const char *dir);
 void add_to_alternates_memory(const char *dir);
 
 /*
- * Populate an odb's loose object cache for one particular subdirectory (i.e.,
- * the one that corresponds to the first byte of objects you're interested in,
- * from 0 to 255 inclusive).
+ * Populate and return the loose object cache array corresponding to the
+ * given object ID.
  */
-void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
+struct oid_array *odb_loose_cache(struct object_directory *odb,
+				  const struct object_id *oid);
 
 struct packed_git {
 	struct packed_git *next;
diff --git a/sha1-file.c b/sha1-file.c
index d2f5e65865..38af6d5d0b 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -924,7 +924,6 @@ static int open_sha1_file(struct repository *r,
 static int quick_has_loose(struct repository *r,
 			   const unsigned char *sha1)
 {
-	int subdir_nr = sha1[0];
 	struct object_id oid;
 	struct object_directory *odb;
 
@@ -932,9 +931,7 @@ static int quick_has_loose(struct repository *r,
 
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
-		odb_load_loose_cache(odb, subdir_nr);
-		if (oid_array_lookup(&odb->loose_objects_cache[subdir_nr],
-				     &oid) >= 0)
+		if (oid_array_lookup(odb_loose_cache(odb, &oid), &oid) >= 0)
 			return 1;
 	}
 	return 0;
@@ -2159,24 +2156,24 @@ static int append_loose_object(const struct object_id *oid, const char *path,
 	return 0;
 }
 
-void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
+struct oid_array *odb_loose_cache(struct object_directory *odb,
+				  const struct object_id *oid)
 {
+	int subdir_nr = oid->hash[0];
+	struct oid_array *subdir_array = &odb->loose_objects_cache[subdir_nr];
 	struct strbuf buf = STRBUF_INIT;
 
-	if (subdir_nr < 0 ||
-	    subdir_nr >= ARRAY_SIZE(odb->loose_objects_subdir_seen))
-		BUG("subdir_nr out of range");
-
 	if (odb->loose_objects_subdir_seen[subdir_nr])
-		return;
+		return subdir_array;
 
 	strbuf_addstr(&buf, odb->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    append_loose_object,
 				    NULL, NULL,
-				    &odb->loose_objects_cache[subdir_nr]);
+				    subdir_array);
 	odb->loose_objects_subdir_seen[subdir_nr] = 1;
 	strbuf_release(&buf);
+	return subdir_array;
 }
 
 static int check_stream_sha1(git_zstream *stream,
diff --git a/sha1-name.c b/sha1-name.c
index fdb22147b2..4fc6368ce5 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -87,7 +87,6 @@ static int match_sha(unsigned, const unsigned char *, const unsigned char *);
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
-	int subdir_nr = ds->bin_pfx.hash[0];
 	struct object_directory *odb;
 
 	for (odb = the_repository->objects->odb;
@@ -96,8 +95,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		int pos;
 		struct oid_array *loose_subdir_objects;
 
-		odb_load_loose_cache(odb, subdir_nr);
-		loose_subdir_objects = &odb->loose_objects_cache[subdir_nr];
+		loose_subdir_objects = odb_loose_cache(odb, &ds->bin_pfx);
 		pos = oid_array_lookup(loose_subdir_objects, &ds->bin_pfx);
 		if (pos < 0)
 			pos = -1 - pos;
-- 
2.19.2
